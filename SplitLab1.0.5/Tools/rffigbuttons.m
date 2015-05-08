function rffigbuttons(fig)
%create buttons for seismogram plot SL_SeismoViewer and assings callbacks
global thisrf

if nargin<1
    fig =gcf;
end
ht = uitoolbar(fig);

load('icon.mat');

uipushtool(ht,'CData',icon.back,...
    'TooltipString','previous receiver function',...
    'ClickedCallback', 'idx = thisrf.index-1; if idx < 1; idx = length(rf);end; RfViewer(idx); clear idx',...
    'BusyAction','Cancel');

uipushtool(ht,'CData',icon.camera,...
    'TooltipString','save grafic ...',...
    'ClickedCallback',@localSavePicture);

% uipushtool(ht,'CData',icon.save,...
%     'TooltipString','save receiver function',...
%     'ClickedCallback', 'saverf(thisrf.index)',...
%     'BusyAction','Cancel');

uipushtool(ht,'CData',icon.sac,...
    'TooltipString','view seismic wave',...
    'ClickedCallback',';if config.isoldver;SL_SeismoViewer4old(config.db_index);else;SL_SeismoViewer(config.db_index);end');

uipushtool(ht,'CData',icon.next,...
    'TooltipString','next receiver function',...
    'ClickedCallback', 'idx = thisrf.index+1;if idx>length(rf);idx=1; button = MFquestdlg([ 0.4 , 0.42 ],''Do you want to quit the database?'',''PS_RecFunc'',''Yes'',''No'',''Yes'');if strcmp(button, ''Yes'');close(gcf);else; RfViewer(idx);end;else;RfViewer(idx);end; clear idx',...
    'BusyAction','Cancel');

uipushtool(ht,'CData',icon.trash,...
    'TooltipString','Remove this RF ...',...
    'ClickedCallback','delRF;');

uipushtool(ht,'CData',icon.open,...
    'TooltipString','Select earthquake from table' ,...
    'ClickedCallback', 'if config.isoldver;SL_databaseViewer4old;else;SL_databaseViewer;end');




function localSavePicture(hFig,evt)
global config thisrf
defaultname = sprintf('%s_%s.preview.',config.stnname,thisrf.seisfile);
defaultextension = strrep(config.exportformat,'.','');
if config.isoldver
       exportfiguredlg4old(gcbf, [defaultname defaultextension])
else
       exportfiguredlg(gcbf, [defaultname defaultextension])
end
