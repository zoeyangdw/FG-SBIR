function [ps cs] = gt_getConnectivities(model, sym, ind, parent)

% returns the connections (i.e. parents and children of the model symbols)

ps = zeros(1000, 1);
cs = zeros(1000, 1);

if sym == model.start
    parent = ind;
end

filterDSymbol = model.rules{sym}(ind).rhs(1);
if ~isempty(model.rules{filterDSymbol})
    filterFSymbol = model.rules{filterDSymbol}.rhs(1);
else
    filterFSymbol = filterDSymbol;
end

filter = model.filters(model.symbols(filterFSymbol).filter);

if ~isfield(filter, 'partNumber')
    filter.partNumber = -1;
end
    
cInd = filter.partNumber + 1;
if ~cInd
    cInd = 1;
end

ps(model.symbols(filterFSymbol).filter) = parent;
cs(model.symbols(filterFSymbol).filter) = cInd;

for r = 2 : length(model.rules{sym}(ind).rhs)
    
    defSymbol = model.rules{sym}(ind).rhs(r);
    strSymbol = model.rules{defSymbol}.rhs(1);
    
    [pps ccs] = gt_getConnectivities(model, strSymbol, 1, model.symbols(filterFSymbol).filter);
    ps = ps + pps;
    cs = cs + ccs;
end