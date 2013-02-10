function varargout = Acotsp(varargin)

%
%      H = ACOTSP returns the handle to a new ACOTSP or the handle to
%      the existing singleton*.
%
%      ACOTSP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ACOTSP.M with the given input arguments.
%
%      ACOTSP('Property','Value',...) creates a new ACOTSP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the INPGUI before Acotsp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Acotsp_OpeningFcn via varargin.

% Begin initialization code 
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Acotsp_OpeningFcn, ...
                   'gui_OutputFcn',  @Acotsp_OutputFcn, ...
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

function Acotsp_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;

guidata(hObject, handles);

initialize_gui(hObject, handles, false);
set(handles.sel_nodes, 'Visible', 'on');
global in;

function varargout = Acotsp_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;




function sel_nodes_Callback(hObject, eventdata, handles)
clear();
global x y;
xlim('manual');ylim('manual');hold on;
[x y]=myginput;hold on;


function calculate2_Callback(hObject, eventdata, handles)
[len,besttour,l]=ants_main(x,y,alpha,beta,noants,iterations,evaporation);
time=cputime-inittime;
set(handles.cputime,'Visible','on');
set(handles.cputime,'String',time);
set(handles.length,'Visible','on');
set(handles.length, 'String',len);
set(handles.clr_path,'Visible','on');
set(handles.route,'Visible','on');
s=blanks(2*(n+1));
for i=1:n+1
    s=strcat(s,num2str(besttour(l,i)));
    if(i~=n+1)
    s=strcat(s,'-> ');
    end
end
%display(s)
set(handles.route,'Visible','on');
set(handles.route, 'String',s);
%test();


function reset2_Callback(hObject, eventdata, handles)
axes(handles.axes1);
cla;
initialize_gui(gcbf, handles, true);
set(handles.route,'Visible','off');
clear();



function alpha_Callback(hObject, eventdata, handles)
alpha = str2double(get(hObject, 'String'));
if isnan(alpha)
    set(hObject, 'String', 2);
    errordlg('Input must be a number','Error');
end
if(alpha<=0)
    set(hObject, 'String', 2);
    errordlg('Alpha must be greater than 0','Error');
end
handles.data.alpha = alpha;
guidata(hObject,handles)


function alpha_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function noants_Callback(hObject, eventdata, handles)
noants = str2double(get(hObject, 'String'));
if isnan(noants)
    set(hObject, 'String', 10);
    errordlg('Input must be a number','Error');
end

if(noants<=0)
    set(hObject, 'String', 10);
    errordlg('Number of ants must be greater than 0','Error');
end

handles.data.noants = noants;
guidata(hObject,handles)



function noants_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function evaporation_Callback(hObject, eventdata, handles)
evaporation = str2double(get(hObject, 'String'));
if (isnan(evaporation)||evaporation>1)
    set(hObject, 'String', 0.1);
    errordlg('Input must be a number','Error');
end

if (evaporation>1)
    set(hObject, 'String', 0.1);
    errordlg('Input must be less than 1','Error');
end

if(evaporation<=0)
    set(hObject, 'String', 0.1);
    errordlg('Evaporation coefficient must be greater than 0','Error');
end

handles.data.evaporation = evaporation;
guidata(hObject,handles)


function evaporation_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_Callback(hObject, eventdata, handles)

beta = str2double(get(hObject, 'String'));
if isnan(beta)
    set(hObject, 'String', 5);
    errordlg('Input must be a number','Error');
end

if(beta<=0)
    set(hObject, 'String', 5);
    errordlg('Beta must be greater than 0','Error');
end

handles.data.beta = beta;
guidata(hObject,handles)

function beta_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iterations_Callback(hObject, eventdata, handles)

iterations = str2double(get(hObject, 'String'));
if isnan(iterations)
    set(hObject, 'String', 100);
    errordlg('Input must be a number','Error');
end

if(iterations<=0)
    set(hObject, 'String',100);
    errordlg('Iterations must be greater than 0','Error');
end

handles.data.iterations = iterations;
guidata(hObject,handles)

function iterations_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function initialize_gui(fig_handle, handles, isreset)
if isfield(handles, 'data') && ~isreset
    'hi';
    return;
end
handles.data.alpha = 2;
handles.data.beta = 5;
handles.data.noants = 10;
handles.data.iterations =100;
handles.data.evaporation =0.1;
set(handles.alpha, 'String',handles.data.alpha);
set(handles.beta,  'String',handles.data.beta);
set(handles.noants, 'String',handles.data.noants);
set(handles.iterations, 'String',handles.data.iterations);
set(handles.evaporation, 'String',handles.data.evaporation);
set(handles.nodes,'Visible','off');
set(handles.length,'Visible','off');
set(handles.clr_path,'Visible','off');
set(handles.route,'Visible','off');
set(handles.cputime,'Visible','off');
axis([0 1000 0 1000]);hold on;
guidata(handles.figure1, handles);


function clr_path_Callback(hObject, eventdata, handles)

global x y;
axes(handles.axes1);
cla;
plot(x,y,'o','MarkerEdgeColor','k',...
                                  'MarkerFaceColor','k',...
                                  'MarkerSize',3);hold on;
set(handles.length, 'Visible','off');
set(handles.route,'Visible','off');
set(handles.cputime,'Visible','off');

function uipanel4_SelectionChangeFcn(hObject, eventdata, handles)
if (hObject == handles.inpgui)
    axes(handles.axes1);
    cla;
    initialize_gui(gcbf, handles, true);
    set(handles.route,'Visible','off');
    set(handles.sel_nodes, 'Visible', 'on');
    clear();
else
    axes(handles.axes1);
    cla;
    initialize_gui(gcbf, handles, true);
    set(handles.sel_nodes, 'Visible', 'off');
    set(handles.route,'Visible','off');
    clear();
    global x y in;
    in=uiimport;
    x=in.in(:,2);
    y=in.in(:,3);
    xmax=max(x)+20;ymax=max(y)+20;
    xmin=min(x);ymin=min(y);
    axis([xmin xmax ymin ymax]);hold on;
end
   

