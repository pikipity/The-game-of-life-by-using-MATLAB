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
if isempty(SizeAns)
    NumW=10;
    NumL=10;
else
    NumL=SizeAns{1};
    NumW=SizeAns{2};
    if isequal(NumW,'')
        NumW=10;
    else
        NumW=str2double(NumW);
    end
    if isequal(NumL,'')
        NumL=10;
    else
        NumL=str2double(NumL);
    end
end
% Then Creat a map for the game
GameLifeMatrix=zeros(NumW+2,NumL+2);%create the control matrix.
GameLifeMatrix=rand(size(GameLifeMatrix));%create random number for Game
GameLifeMatrix=round(GameLifeMatrix);%make the number of game be 0 or 1.
%make the fist and the last line and row be 0.
GameLifeMatrix(1,:)=0;GameLifeMatrix(:,1)=0;GameLifeMatrix(NumL+2,:)=0;GameLifeMatrix(:,NumW+2)=0;
figure('Name','The game of life');
hold on;
for x=1:NumL
    for y=1:NumW
        if GameLifeMatrix(y+1,x+1)==0
            rectangle('Position',[x,y,1,1],'edgecolor','k','facecolor','w');
        else
            rectangle('Position',[x,y,1,1],'edgecolor','k','facecolor','r');
        end
    end
end
axis([1 NumL+1 1 NumW+1]);
axis off;
% Let the user input the begining dot location
title('Now, Please Input the begining ''Life'' point.If you have finished input, please ''s'' to quit input','fontsize',10)
GoOn=1;
while GoOn
    [x_mouse,y_mouse,mouse_key]=ginput(1);
    if isempty(mouse_key)
        title('If you want to stop input point, please press ''s''','fontsize',20,'color','r');
    elseif mouse_key==1 || mouse_key==3 || mouse_key==2
        x_mouse=fix(x_mouse);
        y_mouse=fix(y_mouse);
        if x_mouse==NumL+1
            errordlg('Please click the center of a rectangular.','Input a wrong point')
        elseif y_mouse==NumW+1
            errordlg('Please click the center of a rectangular.','Input a wrong point')
        else
            if GameLifeMatrix(y_mouse+1,x_mouse+1)==0
                rectangle('Position',[x_mouse,y_mouse,1,1],'edgecolor','k','facecolor','r');
                GameLifeMatrix(y_mouse+1,x_mouse+1)=1;
            else
                rectangle('Position',[x_mouse,y_mouse,1,1],'edgecolor','k','facecolor','w');
                GameLifeMatrix(y_mouse+1,x_mouse+1)=0;
            end
        end
    elseif mouse_key==115
        GoOn=0;
    else
        title('If you want to stop input point, please press ''s''','fontsize',20,'color','r');
    end
end
% Now, begin to calculate
clear x_mouse y_mouse GoOn SizeAns mouse_key Resize defans name numlines prompt
title('Press "space" to finish.','fontsize',15,'color','k');
x_add=[-1 0 1 -1 1 -1 0 1];
y_add=[-1 -1 -1 0 0 1 1 1];
k=1;
while k
    GameLifeMatrix_copy=GameLifeMatrix;
    s=get(gcf,'currentkey');
    if strcmp(s,'space');
          k=0;
          errordlg('Game has been finished.','Game has been Finish');
    end
    for x=1:NumL
        for y=1:NumW
            Sum=0;
            for n=1:8
                Sum=Sum+GameLifeMatrix(y+1+x_add(n),x+1+y_add(n));
            end
            if Sum==3
                GameLifeMatrix(y+1,x+1)=1;
                rectangle('Position',[x,y,1,1],'edgecolor','k','facecolor','r');
            elseif Sum~=2 && Sum~=3
                GameLifeMatrix(y+1,x+1)=0;
                rectangle('Position',[x,y,1,1],'edgecolor','k','facecolor','w');
            end
        end
    end
    if isequal(GameLifeMatrix,zeros(size(GameLifeMatrix)))
        k=0;
        errordlg('All life has been died.','Game has been finished');
    elseif isequal(GameLifeMatrix,GameLifeMatrix_copy)
        k=0;
        title('The world is in the peace','fontsize',20)
        errordlg('The world is in the peace','Game has been finished')
    end
    pause(1/5)
end
