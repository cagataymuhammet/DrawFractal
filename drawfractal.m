function varargout = drawfractal(varargin)
% DRAWFRACTAL   M-file for drawfractal.fig
%                        by C.Tuffley, Dec 2008/Jan 2009
%
%      DRAWFRACTAL is a gui-based Iterated Function System fractal
%      drawer.  Up to four affine transformations may be specified
%      using text-entry and check boxes; when the "Draw!" button is
%      pushed up to 100 000 iterations of the corresponding "chaos
%      game" are calculated and plotted. The number of iterations may
%      be chosen from a limited number of options in a drop-down menu.
%
%      Each transformation is specified by its
%           * scale factor lambda,
%           * rotation angle theta and centre (u,v),
%           * x- and y-shift translation parameters (x,y),
%      and a reflection parameter mu (= 1 or -1) determined by a
%      checkbox. Scale factors must satisfy 0 <= lambda < 1, and a 
%      warning or error message will occur if any lie outside this range.
%
%      Any reflection will occur in the y-axis =before= the
%      object is rotated; for those wishing to know the gory details,
%      the resulting transformation is
%
%        [z,w]' -> Rot(theta)*[ mu 0 ; 0 1 ]*lambda*([z,w]-[u,v])' 
%                                               + [x,y]' + lambda*[u,v]'.
%
%      Note that this construction restricts the allowed transformations 
%      to similitudes, so arbitrary affine transformations are not possible.
%      The one exception is Transformation four, which has an additional
%      "collapse on y axis?" check box. This sets the reflection parameter
%      mu to zero, which may be used for example to give a fractal fern a
%      stalk.
%      
%      Each transformation may be included/excluded by checking/unchecking
%      the corresponding "include" box. Only the "included" transformations
%      are used for the chaos game. At each step each transformation is
%      chosen with probability approximately proportional to its determinant,
%      i.e. to lambda^2.



%     by Muhammet CAGATAY, May 2016
%     Ide codes had been removed
%     M-File generated for students usage
%     str2num function modified to str2double


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @drawfractal_OpeningFcn, ...
                   'gui_OutputFcn',  @drawfractal_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before drawfractal is made visible.
function drawfractal_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to drawfractal (see VARARGIN)

% Choose default command line output for drawfractal
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes drawfractal wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = drawfractal_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% first transformation %%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in trans1_reflect.
function trans1_reflect_Callback(hObject, eventdata, handles)
% hObject    handle to trans1_reflect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of trans1_reflect

state = get(hObject,'Value');
if state == 1
   set(hObject,'String','yes')
elseif state == -1
   set(hObject,'String','no')
end

input = str2double(get(hObject,'String'));

%checks to see if input is empty. if so, default trans1_rotangle to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);




function trans1_rotcentre_x_Callback(hObject, eventdata, handles)
% hObject    handle to trans1_rotcentre_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans1_rotcentre_x as text
%        str2double(get(hObject,'String')) returns contents of trans1_rotcentre_x as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);





function trans1_rotcentre_y_Callback(hObject, eventdata, handles)
% hObject    handle to trans1_rotcentre_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans1_rotcentre_y as text
%        str2double(get(hObject,'String')) returns contents of trans1_rotcentre_y as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);





function trans1_scale_Callback(hObject, eventdata, handles)
% hObject    handle to trans1_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans1_scale as text
%        str2double(get(hObject,'String')) returns contents of trans1_scale as a double

value = check_scale_factor(get(hObject,'String'));
set(hObject,'String',value)
guidata(hObject, handles);



function trans1_yshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans1_yshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans1_yshift as text
%        str2double(get(hObject,'String')) returns contents of trans1_yshift as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);





function trans1_xshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans1_xshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%        str2double(get(hObject,'String')) returns contents of trans1_xshift as a double



input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%% end of functions for first transform %%
%%%%%%% begin second transform               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in trans2_reflect.
function trans2_reflect_Callback(hObject, eventdata, handles)
% hObject    handle to trans2_reflect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of trans2_reflect

state = get(hObject,'Value');
if state == 1
   set(hObject,'String','yes')
elseif state == -1
   set(hObject,'String','no')
end



function trans2_rotangle_Callback(hObject, eventdata, handles)
% hObject    handle to trans2_rotangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans2_rotangle as text
%        str2double(get(hObject,'String')) returns contents of trans2_rotangle as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);




function trans2_rotcentre_x_Callback(hObject, eventdata, handles)
% hObject    handle to trans2_rotcentre_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans2_rotcentre_x as text
%        str2double(get(hObject,'String')) returns contents of trans2_rotcentre_x as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);






function trans2_rotcentre_y_Callback(hObject, eventdata, handles)
% hObject    handle to trans2_rotcentre_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans2_rotcentre_y as text
%        str2double(get(hObject,'String')) returns contents of trans2_rotcentre_y as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);



function trans2_scale_Callback(hObject, eventdata, handles)
% hObject    handle to trans2_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans2_scale as text
%        str2double(get(hObject,'String')) returns contents of trans2_scale as a double


value = check_scale_factor(get(hObject,'String'));
set(hObject,'String',value)
guidata(hObject, handles);




function trans2_yshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans2_yshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans2_yshift as text
%        str2double(get(hObject,'String')) returns contents of trans2_yshift as a double


input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);



function trans2_xshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans2_xshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans2_xshift as text
%        str2double(get(hObject,'String')) returns contents of trans2_xshift as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% end of functions for transform 2 %%%%%%%%%% %%%%%
%%%%%%%%%% begin third transform            %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in trans3_reflect.
function trans3_reflect_Callback(hObject, eventdata, handles)
% hObject    handle to trans3_reflect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of trans3_reflect

state = get(hObject,'Value');
if state == 1
   set(hObject,'String','yes')
elseif state == -1
   set(hObject,'String','no')
end


function trans3_rotangle_Callback(hObject, eventdata, handles)
% hObject    handle to trans3_rotangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans3_rotangle as text
%        str2double(get(hObject,'String')) returns contents of trans3_rotangle as a double

input = str2double(get(hObject,'String'));
%checks to see if input is empty. if so, default trans3_rotangle to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);




function trans3_rotcentre_x_Callback(hObject, eventdata, handles)
% hObject    handle to trans3_rotcentre_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans3_rotcentre_x as text
%        str2double(get(hObject,'String')) returns contents of trans3_rotcentre_x as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);




function trans3_rotcentre_y_Callback(hObject, eventdata, handles)
% hObject    handle to trans3_rotcentre_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans3_rotcentre_y as text
%        str2double(get(hObject,'String')) returns contents of trans3_rotcentre_y as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function trans3_rotcentre_y_CreateFcn(hObject, eventdata, handles)
% hObject    handle to trans3_rotcentre_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function trans3_scale_Callback(hObject, eventdata, handles)
% hObject    handle to trans3_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans3_scale as text
%        str2double(get(hObject,'String')) returns contents of trans3_scale as a double

value = check_scale_factor(get(hObject,'String'));
set(hObject,'String',value)
guidata(hObject, handles);




function trans3_yshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans3_yshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans3_yshift as text
%        str2double(get(hObject,'String')) returns contents of trans3_yshift as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);



function trans3_xshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans3_xshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans3_xshift as text
%        str2double(get(hObject,'String')) returns contents of trans3_xshift as a double


input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% End third transform          %%%%%%%%%%%%%%%
%%%%%   begin fourth               %%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function trans4_scale_Callback(hObject, eventdata, handles)
% hObject    handle to trans4_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans4_scale as text
%        str2double(get(hObject,'String')) returns contents of trans4_scale as a double

value = check_scale_factor(get(hObject,'String'));
set(hObject,'String',value)
guidata(hObject, handles);





function trans4_rotangle_Callback(hObject, eventdata, handles)
% hObject    handle to trans4_rotangle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans4_rotangle as text
%        str2double(get(hObject,'String')) returns contents of trans4_rotangle as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);




function trans4_rotcentre_x_Callback(hObject, eventdata, handles)
% hObject    handle to trans4_rotcentre_x (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans4_rotcentre_x as text
%        str2double(get(hObject,'String')) returns contents of trans4_rotcentre_x as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);



function trans4_rotcentre_y_Callback(hObject, eventdata, handles)
% hObject    handle to trans4_rotcentre_y (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans4_rotcentre_y as text
%        str2double(get(hObject,'String')) returns contents of trans4_rotcentre_y as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);




function trans4_xshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans4_xshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans4_xshift as text
%        str2double(get(hObject,'String')) returns contents of trans4_xshift as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);





function trans4_yshift_Callback(hObject, eventdata, handles)
% hObject    handle to trans4_yshift (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of trans4_yshift as text
%        str2double(get(hObject,'String')) returns contents of trans4_yshift as a double

input = str2double(get(hObject,'String'));
 
%checks to see if input is empty. if so, default to zero
if (isempty(input))
     set(hObject,'String','0')
end
guidata(hObject, handles);





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Sanity checks %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function value = check_scale_factor(entry)

input = str2double(entry);

%checks to see if input is empty. if so, default to zero
if (isempty(input))
     value = '0';
     return
end

if ~((input >= 0) & (input < 1))
   warndlg('Scale factors must satisfy 0 <= x < 1','Outside range!')
end
value = entry;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Iterations menu             %%%%%%%%%%%%%%%%
%%%%%%%%   (unmodified from default) %%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%  Draw the fractal %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --- Executes on button press in draw_button.
function draw_button_Callback(hObject, eventdata, handles)
% hObject    handle to draw_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figurehandle = gcf;
%"drawing" message
busybox = msgbox('Drawing, please wait...');

%initialise transform matrix
transform = [];

%create first transformation

if get(handles.trans1_include,'Value')

reflect = -get(handles.trans1_reflect,'Value');
scale = str2double(get(handles.trans1_scale,'String'));
angle   = str2double(get(handles.trans1_rotangle,'String'));
centre  = [ str2double(get(handles.trans1_rotcentre_x,'String')) str2double(get(handles.trans1_rotcentre_y,'String')) ];
translate = [ str2double(get(handles.trans1_xshift,'String')) str2double(get(handles.trans1_yshift,'String')) ];

transform = [ scale reflect angle translate centre ];
end


%create second transformation

if get(handles.trans2_include,'Value')
reflect = -get(handles.trans2_reflect,'Value');
scale = str2double(get(handles.trans2_scale,'String'));
angle   = str2double(get(handles.trans2_rotangle,'String'));
centre  = [ str2double(get(handles.trans2_rotcentre_x,'String')) str2double(get(handles.trans2_rotcentre_y,'String')) ];
translate = [ str2double(get(handles.trans2_xshift,'String')) str2double(get(handles.trans2_yshift,'String')) ];

transform = [ transform ; scale reflect angle translate centre];
end


%create third transformation

if get(handles.trans3_include,'Value')

reflect = -get(handles.trans3_reflect,'Value');
scale = str2double(get(handles.trans3_scale,'String'));
angle   = str2double(get(handles.trans3_rotangle,'String'));
centre  = [ str2double(get(handles.trans3_rotcentre_x,'String')) str2double(get(handles.trans3_rotcentre_y,'String')) ];
translate = [ str2double(get(handles.trans3_xshift,'String')) str2double(get(handles.trans3_yshift,'String')) ];

transform = [ transform ; scale reflect angle translate centre ];

end


%create fourth transformation

if get(handles.trans4_include,'Value')

reflect = -get(handles.trans4_reflect,'Value');
if get(handles.trans4_collapse,'Value')
   reflect = 0;
end
scale = str2double(get(handles.trans4_scale,'String'));
angle   = str2double(get(handles.trans4_rotangle,'String'));
centre  = [ str2double(get(handles.trans4_rotcentre_x,'String')) str2double(get(handles.trans4_rotcentre_y,'String')) ];
translate = [ str2double(get(handles.trans4_xshift,'String')) str2double(get(handles.trans4_yshift,'String')) ];

transform = [ transform ; scale reflect angle translate centre ];

end


parameters = transform;

[n,m]  = size(parameters);
if isempty(parameters)
   errordlg('No transformations specified. Please tick one or more "include" boxes.','No transforms!')
   close(busybox)
   return
end


scale = parameters(:,1);
reflect  = sign(parameters(:,2));
theta  = parameters(:,3);
preshift = [ parameters(:,6)'; parameters(:,7)' ];
shift  = [ parameters(:,4)'; parameters(:,5)' ] + preshift*diag(scale);


factor = max(abs(scale));
if ~((factor >= 0) & (factor < 1))
       errordlg('A scale factor is outside the allowed range. They must satisfy 0<=x<1.','Scale factor outside range!')
   close(busybox)
return
end

Map = zeros(2,2,n);

for i=1:n

Rotation = [ cosd(theta(i)) -sind(theta(i)) ; sind(theta(i)) cosd(theta(i)) ];

Reflect  = [ reflect(i) 0 ; 0 1 ];
Scale    = scale(i)*eye(2);
Map(:,:,i) = Rotation*Reflect*Scale;

end

detvec = abs(reflect.*scale.^2);
tol = 0.25*min(detvec(detvec>0));
detvec = detvec+tol;
weights = detvec/sum(detvec);
cweights = cumsum(weights);

%get numer of iterations from menu
switch get(handles.menu_iterations,'Value')   
    case 1
        max_iterations = 10000;        
    case 2
        max_iterations = 50000;        
    case 3
        max_iterations = 100000;        
    otherwise
end

x = zeros(2,max_iterations);
y = rand(2,1);

for i = 1:100
map = sample(cweights);
     y = Map(:,:,map)*(y-preshift(:,map)) + shift(:,map);
end

x(:,1) = y;

for i = 2:max_iterations
map = sample(cweights);
     x(:,i) = Map(:,:,map)*(x(:,i-1)-preshift(:,map)) + shift(:,map);
end

figure(figurehandle)
plot(x(1,:),x(2,:),'b.','MarkerSize',0.1)
axis equal
%axis off
close(busybox)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% sampler
function choice = sample(cumweight)
     r = rand;
     choice = min(find(cumweight>r));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Quit button %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --- Executes on button press in quit_button.
function quit_button_Callback(hObject, eventdata, handles)
% hObject    handle to quit_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


confirmquit = questdlg('Quit "drawfractal?"','Quit?','Yes','No','Yes');

switch confirmquit
   case 'Yes'
     closereq
   case 'No'
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% end quit button %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%% Actions menu  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% --------------------------------------------------------------------
function action_save_Callback(hObject, eventdata, handles)
% hObject    handle to action_save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%% based on code created by Quan Quach, of blinkdagger.com
%% code is included below

savePlotWithinGUI(handles.axes1)

% --------------------------------------------------------------------
function action_print_Callback(hObject, eventdata, handles)
% hObject    handle to action_print (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

confirmprint = questdlg('Print fractal?','Print?','Yes','No','Yes');

switch confirmprint
   case 'Yes'
     printPlotWithinGUI(handles.axes1)
   case 'No'
end

% --------------------------------------------------------------------
function actions_save_values_Callback(hObject, eventdata, handles)
% hObject    handle to actions_save_values (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%allow the user to specify where to save the settings file
[filename,pathname] = uiputfile('fractal.fig','Save your current values');
 
if pathname == 0 %if the user pressed cancelled, then we exit this callback
    return
end
%construct the path name of the save location
saveDataName = fullfile(pathname,filename); 
 
%saves the gui data
hgsave(saveDataName);

% --------------------------------------------------------------------
function action_load_Callback(hObject, eventdata, handles)
% hObject    handle to action_load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%allow the user to choose which settings to load
[filename, pathname] = uigetfile('*.fig', 'Choose file to load values from');
 
%construct the path name of the file to be loaded
loadDataName = fullfile(pathname,filename);
 
%this is the gui that will be closed once we load the new settings
theCurrentGUI = gcf;  
 
%load the settings, which creates a new gui
hgload(loadDataName); 
 
%closes the old gui
close(theCurrentGUI);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% Gallery menu -- predefined fractals %%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% --------------------------------------------------------------------
function gallery_sierpinski_Callback(hObject, eventdata, handles)
set(handles.trans1_reflect,'Value',-1)
set(handles.trans1_reflect,'String','no')
set(handles.trans1_scale,'String','0.5')
set(handles.trans1_rotangle,'String','0')
set(handles.trans1_rotcentre_x,'String','0')
set(handles.trans1_rotcentre_y,'String','0')
set(handles.trans1_xshift,'String','0')
set(handles.trans1_yshift,'String','0')
set(handles.trans1_include,'Value',1)

set(handles.trans2_reflect,'Value',-1)
set(handles.trans2_reflect,'String','no')
set(handles.trans2_scale,'String','0.5')
set(handles.trans2_rotangle,'String','0')
set(handles.trans2_rotcentre_x,'String','0')
set(handles.trans2_rotcentre_y,'String','0')
set(handles.trans2_xshift,'String','1')
set(handles.trans2_yshift,'String','0')
set(handles.trans2_include,'Value',1)

set(handles.trans3_reflect,'Value',-1)
set(handles.trans3_reflect,'String','no')
set(handles.trans3_scale,'String','0.5')
set(handles.trans3_rotangle,'String','0')
set(handles.trans3_rotcentre_x,'String','0')
set(handles.trans3_rotcentre_y,'String','0')
set(handles.trans3_xshift,'String','1/2')
set(handles.trans3_yshift,'String','sqrt(3)/2')
set(handles.trans3_include,'Value',1)

set(handles.trans4_reflect,'Value',-1)
set(handles.trans4_reflect,'String','no')
set(handles.trans4_scale,'String','0')
set(handles.trans4_rotangle,'String','0')
set(handles.trans4_rotcentre_x,'String','0')
set(handles.trans4_rotcentre_y,'String','0')
set(handles.trans4_xshift,'String','0')
set(handles.trans4_yshift,'String','0')
set(handles.trans4_include,'Value',0)
set(handles.trans4_collapse,'Value',0)



% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
set(handles.trans1_reflect,'Value',-1)
set(handles.trans1_reflect,'String','no')
set(handles.trans1_scale,'String','0.5')
set(handles.trans1_rotangle,'String','0')
set(handles.trans1_rotcentre_x,'String','0')
set(handles.trans1_rotcentre_y,'String','0')
set(handles.trans1_xshift,'String','0')
set(handles.trans1_yshift,'String','0')
set(handles.trans1_include,'Value',1)

set(handles.trans2_reflect,'Value',-1)
set(handles.trans2_reflect,'String','no')
set(handles.trans2_scale,'String','0.5')
set(handles.trans2_rotangle,'String','0')
set(handles.trans2_rotcentre_x,'String','0')
set(handles.trans2_rotcentre_y,'String','0')
set(handles.trans2_xshift,'String','1')
set(handles.trans2_yshift,'String','0')
set(handles.trans2_include,'Value',1)

set(handles.trans3_reflect,'Value',-1)
set(handles.trans3_reflect,'String','no')
set(handles.trans3_scale,'String','0.5')
set(handles.trans3_rotangle,'String','0')
set(handles.trans3_rotcentre_x,'String','0')
set(handles.trans3_rotcentre_y,'String','0')
set(handles.trans3_xshift,'String','0')
set(handles.trans3_yshift,'String','1')
set(handles.trans3_include,'Value',1)

set(handles.trans4_reflect,'Value',-1)
set(handles.trans4_reflect,'String','no')
set(handles.trans4_scale,'String','0')
set(handles.trans4_rotangle,'String','0')
set(handles.trans4_rotcentre_x,'String','0')
set(handles.trans4_rotcentre_y,'String','0')
set(handles.trans4_xshift,'String','0')
set(handles.trans4_yshift,'String','0')
set(handles.trans4_include,'Value',0)
set(handles.trans4_collapse,'Value',0)




% --------------------------------------------------------------------
function gallery_fern_Callback(hObject, eventdata, handles)
set(handles.trans1_reflect,'Value',-1)
set(handles.trans1_reflect,'String','no')
set(handles.trans1_scale,'String','0.8')
set(handles.trans1_rotangle,'String','5')
set(handles.trans1_rotcentre_x,'String','0')
set(handles.trans1_rotcentre_y,'String','0')
set(handles.trans1_xshift,'String','0')
set(handles.trans1_yshift,'String','3')
set(handles.trans1_include,'Value',1)

set(handles.trans2_reflect,'Value',-1)
set(handles.trans2_reflect,'String','no')
set(handles.trans2_scale,'String','0.3')
set(handles.trans2_rotangle,'String','-80')
set(handles.trans2_rotcentre_x,'String','0')
set(handles.trans2_rotcentre_y,'String','0')
set(handles.trans2_xshift,'String','0')
set(handles.trans2_yshift,'String','2')
set(handles.trans2_include,'Value',1)

set(handles.trans3_reflect,'Value',-1)
set(handles.trans3_reflect,'String','no')
set(handles.trans3_scale,'String','0')
set(handles.trans3_rotangle,'String','0')
set(handles.trans3_rotcentre_x,'String','0')
set(handles.trans3_rotcentre_y,'String','0')
set(handles.trans3_xshift,'String','0')
set(handles.trans3_yshift,'String','0')
set(handles.trans3_include,'Value',0)

set(handles.trans4_reflect,'Value',-1)
set(handles.trans4_reflect,'String','no')
set(handles.trans4_scale,'String','0.24')
set(handles.trans4_rotangle,'String','0')
set(handles.trans4_rotcentre_x,'String','0')
set(handles.trans4_rotcentre_y,'String','0')
set(handles.trans4_xshift,'String','0')
set(handles.trans4_yshift,'String','0')
set(handles.trans4_include,'Value',1)
set(handles.trans4_collapse,'Value',1)


function gallery_dragon_Callback(hObject, eventdata, handles)

set(handles.trans1_reflect,'Value',-1)
set(handles.trans1_reflect,'String','no')
set(handles.trans1_scale,'String','0.66')
set(handles.trans1_rotangle,'String','40')
set(handles.trans1_rotcentre_x,'String','0')
set(handles.trans1_rotcentre_y,'String','0')
set(handles.trans1_xshift,'String','0')
set(handles.trans1_yshift,'String','1.5')
set(handles.trans1_include,'Value',1)

set(handles.trans2_reflect,'Value',-1)
set(handles.trans2_reflect,'String','no')
set(handles.trans2_scale,'String','0.66')
set(handles.trans2_rotangle,'String','40')
set(handles.trans2_rotcentre_x,'String','0')
set(handles.trans2_rotcentre_y,'String','0')
set(handles.trans2_xshift,'String','0')
set(handles.trans2_yshift,'String','0')
set(handles.trans2_include,'Value',1)

set(handles.trans3_reflect,'Value',-1)
set(handles.trans3_reflect,'String','no')
set(handles.trans3_scale,'String','0')
set(handles.trans3_rotangle,'String','0')
set(handles.trans3_rotcentre_x,'String','0')
set(handles.trans3_rotcentre_y,'String','0')
set(handles.trans3_xshift,'String','0')
set(handles.trans3_yshift,'String','0')
set(handles.trans3_include,'Value',0)

set(handles.trans4_reflect,'Value',-1)
set(handles.trans4_reflect,'String','no')
set(handles.trans4_scale,'String','0')
set(handles.trans4_rotangle,'String','0')
set(handles.trans4_rotcentre_x,'String','0')
set(handles.trans4_rotcentre_y,'String','0')
set(handles.trans4_xshift,'String','0')
set(handles.trans4_yshift,'String','0')
set(handles.trans4_include,'Value',0)
set(handles.trans4_collapse,'Value',0)


% --------------------------------------------------------------------
function gallery_LLL_Callback(hObject, eventdata, handles)
set(handles.trans1_reflect,'Value',-1)
set(handles.trans1_reflect,'String','no')
set(handles.trans1_scale,'String','0.5')
set(handles.trans1_rotangle,'String','0')
set(handles.trans1_rotcentre_x,'String','0')
set(handles.trans1_rotcentre_y,'String','0')
set(handles.trans1_xshift,'String','0')
set(handles.trans1_yshift,'String','0')
set(handles.trans1_include,'Value',1)

set(handles.trans2_reflect,'Value',-1)
set(handles.trans2_reflect,'String','no')
set(handles.trans2_scale,'String','0.5')
set(handles.trans2_rotangle,'String','0')
set(handles.trans2_rotcentre_x,'String','0')
set(handles.trans2_rotcentre_y,'String','0')
set(handles.trans2_xshift,'String','-1')
set(handles.trans2_yshift,'String','0')
set(handles.trans2_include,'Value',1)

set(handles.trans3_reflect,'Value',-1)
set(handles.trans3_reflect,'String','no')
set(handles.trans3_scale,'String','0.5')
set(handles.trans3_rotangle,'String','90')
set(handles.trans3_rotcentre_x,'String','0')
set(handles.trans3_rotcentre_y,'String','0')
set(handles.trans3_xshift,'String','0')
set(handles.trans3_yshift,'String','2')
set(handles.trans3_include,'Value',1)

set(handles.trans4_reflect,'Value',-1)
set(handles.trans4_reflect,'String','no')
set(handles.trans4_scale,'String','0')
set(handles.trans4_rotangle,'String','0')
set(handles.trans4_rotcentre_x,'String','0')
set(handles.trans4_rotcentre_y,'String','0')
set(handles.trans4_xshift,'String','0')
set(handles.trans4_yshift,'String','0')
set(handles.trans4_include,'Value',0)
set(handles.trans4_collapse,'Value',0)


% --------------------------------------------------------------------
function gallery_curl_Callback(hObject, eventdata, handles)
set(handles.trans1_reflect,'Value',-1)
set(handles.trans1_reflect,'String','no')
set(handles.trans1_scale,'String','0.95')
set(handles.trans1_rotangle,'String','10')
set(handles.trans1_rotcentre_x,'String','0')
set(handles.trans1_rotcentre_y,'String','0')
set(handles.trans1_xshift,'String','1')
set(handles.trans1_yshift,'String','-1/2')
set(handles.trans1_include,'Value',1)

set(handles.trans2_reflect,'Value',-1)
set(handles.trans2_reflect,'String','no')
set(handles.trans2_scale,'String','1/8')
set(handles.trans2_rotangle,'String','140')
set(handles.trans2_rotcentre_x,'String','0')
set(handles.trans2_rotcentre_y,'String','0')
set(handles.trans2_xshift,'String','0')
set(handles.trans2_yshift,'String','4')
set(handles.trans2_include,'Value',1)

set(handles.trans3_reflect,'Value',-1)
set(handles.trans3_reflect,'String','no')
set(handles.trans3_scale,'String','0')
set(handles.trans3_rotangle,'String','0')
set(handles.trans3_rotcentre_x,'String','0')
set(handles.trans3_rotcentre_y,'String','0')
set(handles.trans3_xshift,'String','0')
set(handles.trans3_yshift,'String','0')
set(handles.trans3_include,'Value',0)

set(handles.trans4_reflect,'Value',-1)
set(handles.trans4_reflect,'String','no')
set(handles.trans4_scale,'String','0')
set(handles.trans4_rotangle,'String','0')
set(handles.trans4_rotcentre_x,'String','0')
set(handles.trans4_rotcentre_y,'String','0')
set(handles.trans4_xshift,'String','0')
set(handles.trans4_yshift,'String','0')
set(handles.trans4_include,'Value',0)
set(handles.trans4_collapse,'Value',0)


% --------------------------------------------------------------------
function gallery_koch_Callback(hObject, eventdata, handles)

set(handles.trans1_reflect,'Value',-1)
set(handles.trans1_reflect,'String','no')
set(handles.trans1_scale,'String','1/3')
set(handles.trans1_rotangle,'String','0')
set(handles.trans1_rotcentre_x,'String','0')
set(handles.trans1_rotcentre_y,'String','0')
set(handles.trans1_xshift,'String','0')
set(handles.trans1_yshift,'String','0')
set(handles.trans1_include,'Value',1)

set(handles.trans2_reflect,'Value',-1)
set(handles.trans2_reflect,'String','no')
set(handles.trans2_scale,'String','1/3')
set(handles.trans2_rotangle,'String','0')
set(handles.trans2_rotcentre_x,'String','0')
set(handles.trans2_rotcentre_y,'String','0')
set(handles.trans2_xshift,'String','2')
set(handles.trans2_yshift,'String','0')
set(handles.trans2_include,'Value',1)

set(handles.trans3_reflect,'Value',-1)
set(handles.trans3_reflect,'String','no')
set(handles.trans3_scale,'String','1/3')
set(handles.trans3_rotangle,'String','60')
set(handles.trans3_rotcentre_x,'String','0')
set(handles.trans3_rotcentre_y,'String','0')
set(handles.trans3_xshift,'String','1')
set(handles.trans3_yshift,'String','0')
set(handles.trans3_include,'Value',1)

set(handles.trans4_reflect,'Value',-1)
set(handles.trans4_reflect,'String','no')
set(handles.trans4_scale,'String','1/3')
set(handles.trans4_rotangle,'String','-60')
set(handles.trans4_rotcentre_x,'String','0')
set(handles.trans4_rotcentre_y,'String','0')
set(handles.trans4_xshift,'String','1.5')
set(handles.trans4_yshift,'String','sqrt(3)/2')
set(handles.trans4_include,'Value',1)
set(handles.trans4_collapse,'Value',0)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Code for saving plots                %%%%%%%
%%%%%%%%%%   based on code                      %%%%%%%
%%%%%%%%%%   due to Quan Quach, blinkdagger.com %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%created by: Quan Quach
%date: 11/8/07 (with modifications by C. Tuffley, Dec 08/Jan 09)
%function to save plots within a GUI
 
function savePlotWithinGUI(axesObject, legendObject)
%this function takes in two arguments
%axesObject is the axes object that will be saved (required input)
%legendObject is the legend object that will be saved (optional input)
 
%stores savepath for the phase plot
[filename, pathname] = uiputfile({'*.eps','Encapsulated postscript (*.eps)';...
        '*.jpg','Jpeg (*.jpg)';...
        '*.emf','Enhanced Meta File (*.emf)';...
        '*.bmp','Bitmap (*.bmp)'; '*.fig','Figure (*.fig)'}, ... 
        'Save picture as','untitled.eps');
 
%if user cancels save command, nothing happens
if isequal(filename,0) || isequal(pathname,0)
    return
end
if isempty(filename)
   filename = 'fractalfig.eps';
end

%create a new figure
newFig = figure;
 
%get the units and position of the axes object
axes_units = get(axesObject,'Units');
axes_pos = get(axesObject,'Position');
 
%copies axesObject onto new figure
axesObject2 = copyobj(axesObject,newFig);
 
%realign the axes object on the new figure
set(axesObject2,'Units',axes_units);
set(axesObject2,'Position',[15 5 axes_pos(3) axes_pos(4)]);
 
%if a legendObject was passed to this function . . .
if (exist('legendObject'))
 
    %get the units and position of the legend object
    legend_units = get(legendObject,'Units');
    legend_pos = get(legendObject,'Position');
 
    %copies the legend onto the the new figure
    legendObject2 = copyobj(legendObject,newFig);
 
    %realign the legend object on the new figure
    set(legendObject2,'Units',legend_units);
    set(legendObject2,'Position',[15-axes_pos(1)+legend_pos(1) 5-axes_pos(2)+legend_pos(2) legend_pos(3) legend_pos(4)] );
 
end
 
%adjusts the new figure accordingly
set(newFig,'Units',axes_units);
set(newFig,'Position',[15 5 axes_pos(3)+30 axes_pos(4)+10]);
 
%saves the plot
axis off
saveas(newFig,fullfile(pathname, filename)) 
 
%closes the figure
close(newFig)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%% Code for printing plots              %%%%%%%
%%%%%%%%%%   based on Quan Quach's code         %%%%%%%
%%%%%%%%%%   for saving plots (see above)       %%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function printPlotWithinGUI(axesObject, legendObject)
%this function takes in two arguments
%axesObject is the axes object that will be saved (required input)
%legendObject is the legend object that will be saved (optional input)
 
%create a new figure
newFig = figure;
 
%get the units and position of the axes object
axes_units = get(axesObject,'Units');
axes_pos = get(axesObject,'Position');
 
%copies axesObject onto new figure
axesObject2 = copyobj(axesObject,newFig);
 
%realign the axes object on the new figure
set(axesObject2,'Units',axes_units);
set(axesObject2,'Position',[15 5 axes_pos(3) axes_pos(4)]);
 
%if a legendObject was passed to this function . . .
if (exist('legendObject'))
 
    %get the units and position of the legend object
    legend_units = get(legendObject,'Units');
    legend_pos = get(legendObject,'Position');
 
    %copies the legend onto the the new figure
    legendObject2 = copyobj(legendObject,newFig);
 
    %realign the legend object on the new figure
    set(legendObject2,'Units',legend_units);
    set(legendObject2,'Position',[15-axes_pos(1)+legend_pos(1) 5-axes_pos(2)+legend_pos(2) legend_pos(3) legend_pos(4)] );
 
end
 
%adjusts the new figure accordingly
set(newFig,'Units',axes_units);
set(newFig,'Position',[15 5 axes_pos(3)+30 axes_pos(4)+10]);
axis off
print(newFig)
close(newFig)
