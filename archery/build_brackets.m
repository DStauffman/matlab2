function [seeds] = build_brackets(waves)

% BUILD_BRACKETS  builds the brackets based on the seeds for the given wave.
%
% Input:
%     waves : (scalar) number of waves that will be used in the bracket.
%
% Output:
%     seeds : (1xN) list of seeds [num]
%
% Prototype:
%     seeds = build_brackets(0);
%     seeds = build_brackets(1);
%     seeds = build_brackets(2);
%     seeds = build_brackets(3);
%
% Change Log:
%     1.  Written by David Stauffer in Feb 2014.

seeds = [1 2 3];
for i = 1:waves
    this_complement = 3*2^i+1;
    for j = length(seeds):-1:1
        seeds = [seeds(1:j), this_complement-seeds(j),seeds(j+1:end)];
    end
end