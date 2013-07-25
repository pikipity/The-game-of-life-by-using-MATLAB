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
        rectangle('Position',[x,y,1,1],'edgecolor','k','facecolor','w');
    end
end
axis([1 NumL+1 1 NumW+1]);
axis off;
% Let the user input the begining dot location
title('Now, Please Input the begining ''Life'' point.If you have finished input, please any key to quit input','fontsize',10)
GoOn=1;
while GoOn
    [x_mouse,y_mouse,mouse_key]=ginput(1);
    if mouse_key==1 || mouse_key==3 || mouse_key==2
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
    else
        GoOn=0;
    end
end
% Now, begin to calculate
title('Press "space" to finish.','fontsize',15);
pause(1)
x_add=[-1 0 1 -1 1 -1 0 1];
y_add=[-1 -1 -1 0 0 1 1 1];
k=1;
while k
    s=get(gcf,'currentkey');
    if strcmp(s,'space');
          k=0;
    end
    for x=1:NumL
        for y=1:NumW
            Sum=0;
            for n=1:8
                Sum=Sum+GameLifeMatrix(y+1+x_add(n),x+1+y_add(n));
            end
            if (GameLifeMatrix(y+1,x+1)==1 && (Sum==2 || Sum==3)) || (GameLifeMatrix(y+1,x+1)==0 && Sum==3)
                GameLifeMatrix(y+1,x+1)=1;
                rectangle('Position',[x,y,1,1],'edgecolor','k','facecolor','r');
            else
                GameLifeMatrix(y+1,x+1)=0;
                rectangle('Position',[x,y,1,1],'edgecolor','k','facecolor','w');
            end
        end
    end
    if isequal(GameLifeMatrix,zeros(size(GameLifeMatrix)))
        k=0;
        errordlg('All life has been died.','Game has been Finish');
    end
    pause(0.5)
end
errordlg('Game has been finished.','Game has been Finish');
