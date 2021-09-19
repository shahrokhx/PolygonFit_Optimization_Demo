function varargout = PolygonFit(varargin)
% POLYGONFIT MATLAB code for PolygonFit.fig
%      POLYGONFIT, by itself, creates a new POLYGONFIT or raises the existing
%      singleton*.
%
%      H = POLYGONFIT returns the handle to a new POLYGONFIT or the handle to
%      the existing singleton*.
%
%      POLYGONFIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POLYGONFIT.M with the given input arguments.
%
%      POLYGONFIT('Property','Value',...) creates a new POLYGONFIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PolygonFit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PolygonFit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PolygonFit

% Last Modified by GUIDE v2.5 19-Sep-2021 06:09:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PolygonFit_OpeningFcn, ...
                   'gui_OutputFcn',  @PolygonFit_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
%% Initialization
% movegui('center')
% clear
% End initialization code - DO NOT EDIT


% --- Executes just before PolygonFit is made visible.
function PolygonFit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PolygonFit (see VARARGIN)

% Choose default command line output for PolygonFit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes PolygonFit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PolygonFit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)

% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


n = str2num(get(handles.edit1 ,'string'));
f = str2sym(get(handles.edit2 ,'string'));

% Generate Equation m-file
f_string = char(f);
fid = fopen ('ellipse_equation.m','w');
fprintf(fid,'function f = ellipse_equation(x,y) \n');
fprintf(fid,['    f=',f_string,';\n']);
fprintf(fid,'end \n');
fclose (fid);


% cla(handles.axes1)
h0 = ezplot(handles.axes1,f_string);
set(h0,'LineWidth',5,'Color','k');
grid(handles.axes1,'on');
hold(handles.axes1,'on');

tic;
try 
    [coordinates,~,lambda] = polygon_fit(f,n);
    elapsed_time = toc;
    if isempty(coordinates) % it means it is unsuccessful
        close(gcbf)
        PolyOptX2;

    end
    colors =['r' 'y' 'b' 'c' 'g' 'm'];
    c = colors(floor(rand()*6+1));
    x_poly = coordinates(:,1);
    y_poly = coordinates(:,2);
    hullIndices = convhull(x_poly,y_poly);
    h=fill(x_poly(hullIndices),y_poly(hullIndices),c,'Parent',handles.axes1);
    set(h,'FaceAlpha',0.6);

    max_A = polyarea(x_poly(hullIndices),y_poly(hullIndices));

    set(handles.uitable1,'data',[coordinates])
    set(handles.uitable2,'data',[lambda])
    set(handles.text8,'String',num2str(max_A))
    set(handles.text11,'String',[num2str(elapsed_time,3),' Sec'])
    delete ('ellipse_equation.m')
    delete ('objective_function.m')
catch
    wrnText = sprintf(['Unfortunately, the numerical solver cannot find a',...
                       ' solutoion\nPlease, try one more time.']);
    warndlg(wrnText,'Oops!');
end




% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
web("https://www.sshahi.com/")
