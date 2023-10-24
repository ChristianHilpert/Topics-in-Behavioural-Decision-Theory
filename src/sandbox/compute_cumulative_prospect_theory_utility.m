%{
The function **compute_cumulative_prospect_theory_utility.m** evaluates the 
Tverksy-Kahneman (1992 , :cite:`tvekah1992`) Cumulative Prospect
Theory (CPT) value of a gamble. The function provides the utility level and 
the certainty equivalent (CE) of the gamble. The function expects as input

* a gamble x
* the loss aversion parameter l, 
* the S-shape parameter a, and
* the probabiltiy weighting parameters dp and pd for gains and losses, respectively, and
* the reference point r. 

%}


function [utility, CE] = CPT(a,l,r,dp,dm,x)
%% Auxilliary Variables
% In this section, we define further variables required for the
% computations. We sort the outcomes according to size in the variable _xx_ of length _n_,
% which is split in a gain part _xp_ and a loss part _xn_ of length _n_gain_ and _n_loss_, respectively.
xx =  sort(x-r,'descend');                   
xp = xx(xx>=0);                             
xn = xx(xx<0);                             
n = length(x);                              
n_gain = length(xp);                      
n_loss = length(xn);   
                         
%%
% We define a row vector of indivdual objective probabilities _p_ and
% initialize vector of distorted probabilities _pp_. We compute the
% cumulated sums of the probabilities for the gain and loss parts. This
% gives _p_gain_ and _p_loss_, respectively.
p = 1/n*ones(1,n); 
pp = zeros(1,n);                    
p_gain = cumsum(p(1:n_gain));
p_loss = cumsum(p((n_gain+1):n));

%% Probabiliy Distortion and utility computation
% Now, we compute the probability distortion. 
utility =0;
%% 
% If we have gains, we compute the vector of distorted probabilities $\pi$ for
% the gain part, and add the utility of the gain part to the overall utility. 
if n_gain>0 
    pp(1:n_gain)=(p_gain.^dp)./((p_gain.^dp + (1-p_gain).^dp).^(1/dp))...
        -((p_gain-p(1:n_gain)).^dp)./(((p_gain-p(1:n_gain)).^dp + (1-(p_gain-p(1:n_gain))).^dp).^(1/dp));
    utility =utility+ xp.^a*pp(1:n_gain)';                                  
end
%%
% We repeat the steps for the gain part for the loss part. The only
% difference in computing the loss part of $\pi$ is that we need to reverse
% the order of _pp_ in the loss part.
if n_loss>0
    help=p_loss.^dm./((p_loss.^dm + (1-p_loss).^dm).^(1/dm))...
        -((p_loss-p(1:n_loss)).^dm)./(((p_loss-p(1:n_loss)).^dm + (1-(p_loss-p(1:n_loss))).^dm).^(1/dm));
    pp((n_gain+1):n) =help(end:-1:1);                              
    utility=utility +  (-l.*(-xn).^a)*pp((n_gain+1):n)';           
end
%%
% The last step is to compute the certainty equivalent form the utility
% which is already done. We begin by establishing whether we are in the
% gain or in the loss part with the utility, and then inverse the value
% function.
if utility>=0                                                   
    CE = utility^(1/a)+r ;
else
    CE = -(-utility/l)^(1/a) +r;
end
%% 
% This concludes the function.
end