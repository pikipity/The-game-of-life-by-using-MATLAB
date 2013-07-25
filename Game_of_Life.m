clear;
clc;
% First, let user input the size of the game map
prompt={'Input the length of the game map','Input the wide of the game map'};
name='Enter the size of the game map';
numlines=1;
defans={'10','10'};
Resize='on';
SizeAns=inputdlg(prompt,name,numlines,defans,Resize);
% According to the input, get the length and wide
if isequal(SizeAns,{}) || isequal(size(SizeAns),[2,1])
    NumL=10;
    NumW=10;
else
    NumL=str2double(SizeAns{1});
    NumW=str2double(SizeAns{2});
end
% Then Creat a map for the game
GameLifeMatrix=zeros(NumL+2,NumW+2);%create the control matrix.
figure('Name','The game of life');
hold on;
for x=1:NumL+1
    for y=1:NumW+1
        rectangle('Position',[x,y,1,1],'edgecolor','k');
    end
end
axis([1 NumL+1 1 NumW+1]);
axis off;
% Let the user input the begining dot location
title('Now, Please Input the begining ''Life'' point','fontsize',20)
GoOn=1;
while GoOn==1
    mouse=ginput(1);
    x_mouse=fix(mouse(1));
    y_mouse=fix(mouse(2));
    if x_mouse==NumL+1
        errordlg('Input a wrong point','Please click the center of a rectangular.')
    elseif y_mouse==NumW+1
        errordlg('Input a wrong point','Please click the center of a rectangular.')
    else
        rectangle('Position',[x_mouse,y_mouse,1,1],'edgecolor','k','facecolor','r');
        GameLifeMatrix(y_mouse+1,x_mouse+1)=1;
        GoOn=questdlg('Would you like to input another ''life''?','Another ''Life''?','Yes','No','No');
        if strcmp(GoOn,'Yes')
            GoOn=1;
        else
            GoOn=0;
        end
    end
end