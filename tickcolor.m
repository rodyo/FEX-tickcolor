
function top
    
    imagesc(abs(peaks(10)));
    colormap('bone');
    set(gca, 'XTick', 0:pi:2*pi, 'XTickLabel', {'0', 'p', '2p'}, 'fontname','symbol');
    
    tickcolorA(gcf, [1 1 1])
    
end


function tickcolorA(varargin)

    switch nargin
        case 0
            return;
        case 1
            h = gcf;
            C = varargin{1};
        case 2
            h = varargin{1};
            C = varargin{2};
        case 3
                
        otherwise
    end
    
    if ~ishandle(h)
    end
    
    if ~(ischar(C) && isscalar(C)) || ~(isnumeric(C) && isvector(C) && numel(C)==3)
    end
    
    data = get(h, 'UserData');
    if ~isempty(data) 
        
        if ~isstruct(data) || ~isfield(data,'ID') || ~strcmp(data.ID,'tickcolor')
        end
        
        if ~ishandle(data.original)
            a = get(h, 'CurrentAxes');
        else
            a = data.original;
        end
        
        if ishandle(data.copy)
            delete(data.copy); end
        
    else
        a = get(h, 'CurrentAxes');
    end
    
    % Create copy of the axes, remove labels, and color it
    b = copyobj(a,h);    
    set(b, ...
        'Xcolor'    ,  C, 'YColor'    , C, ...
        'XTickLabel', [], 'YTickLabel', []);    
    
    % Link them together so that zoom/pan works correctly
    linkaxes([a b])
    
    % Put persistent data in the  
    new_data = struct(...
        'ID'      , 'tickcolor',...
        'original', a,...
        'copy'    , b);    
    set(h, 'UserData', new_data);
    
end
