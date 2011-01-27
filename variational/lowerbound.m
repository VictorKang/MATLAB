function l=lowerbound(dvec, w, alpha, beta, a, b)
% l=lowerbound(dvec, w, alpha, beta, a, b)
% Computes lower bound for variational approximation (Buntine & Jakulin
% DCA 2006)
% dvec: data - each column is one image (#pixels=J x #documents=I)
% w: basis - each column is one basis vector (component, psf); (#pixels=J x
% #basis=K)
% alpha, beta: parameters of the Gamma distribution for latent h (1xK each)
% a, b: parameters of the approximative Gamma distribution (1xK each)
%
% There should be another term log(dvec!) but it is constant during
% evaluation...

e_l = psi(a) - log(b); %expectation of <log(l_k)> (1xK)

z=w*exp(e_l); %normalization constant for w (1xK)
t1=e_l*(alpha - a); %(1xK)
t2=dvec*log(z)'; %(JxK)
t3=log((gamma(a).*(beta.^alpha))./(gamma(alpha).*(b.^a))); %(1xK)
l=sum(t1+t3)+sum(t2,2);