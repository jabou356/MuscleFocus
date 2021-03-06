function data = clean_data(data)
% Clean_data allows to select data from the plot and replace it (by NaN, 0 or [])
% Input data should be nframe * observations

% figure
S.fh = figure('units','normalized',...
    'outerposition',[0.1 0.1 0.8 0.8],...
    'menubar','none',...
    'numbertitle','off',...
    'name','GUI_18',...
    'resize','off');
% axes
S.ax = axes('units','normalized',...
    'position',[0.05 0.1 0.8 0.8],...
    'fontsize',8,...
    'nextplot','replacechildren');
% update button
S.but = uicontrol('style','push',...
    'units','normalized',...
    'position',[0.87 0.5 0.1 0.05],...
    'fontsize',14,...
    'string','update',...
    'Callback',{@but_funct,S});

% close button
S.clo = uicontrol('style','push',...
    'units','normalized',...
    'position',[0.87 0.4 0.1 0.05],...
    'fontsize',14,...
    'string','close', ...
    'Callback',@(h,e)closeFig(h,e,S));

    while ishandle(S.fh)
        uiwait(S.fh);
    end
    function but_funct(varargin)
		subplot(3,1,1)
        plot(squeeze(data(:,1,:)))
		
		subplot(3,1,2)
        plot(squeeze(data(:,2,:)))
		
		subplot(3,1,3)
        plot(squeeze(data(:,3,:)))
        
        [pind] = selectdata('selectionmode','Brush');
        
        pind = pind(end:-1:1);
                
        data(:,:,~cellfun('isempty', pind)) = NaN;
    end

    function closeFig(varargin) 
        S = varargin{3};
        delete(S.fh)
    end
end