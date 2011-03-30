function h=init_h(method,peval,image)
% h=init_h(method,peval,image)
% method:   'rand' %random initialization
%           'image' %specified initialization for example image=double(array2im(dpixc_ind))       
%           'image_repmat' %for example image = mean(image,3);        
%           'res' %image is res.w -> initialisation from the nmf results
% addbackgroundcomponent:   1 adds one component flat component as a background (peval.ncomp th)
%                           0 no background component
if ~isfield(peval, 'bgcomp')
    peval.bgcomp = 1;
end

switch method
    case 'rand'
        h = rand(peval.ncomp,peval.nt);        
        msg='h initialzied as uniform random.';
    case 'res'
        h = image;
        msg='h initialized from the results res.w.';        
end
h=max(h, eps); % To avoid zeros...

if isfield (peval,'fid')
    mfprintf(peval.fid, [msg '\n'])
else
    fprintf([msg '\n']);
end

if peval.bgcomp
    h(peval.ncomp,:)=peval.nx*peval.ny*peval.bg;
    mfprintf(peval.fid, 'Last component [%g] of h initialised as a flat background. (background=%g)\n',peval.ncomp,peval.bg);    
end