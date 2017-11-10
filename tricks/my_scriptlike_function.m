function [] = my_scriptlike_function(x, y, z)

% MY_SCRIPTLIKE_FUNCTION  is a function, but runs like a script
%
% Input:
%     None - pulls x, y, and z from the base workspace
%
% Output:
%     None - sets out in the base workspace
%
% Prototype:
%     my_scriptlike_function;
%
% Change Log:
%     1.  Written by David C. Stauffer in February 2016.
%
% Notes:
%     1.  As of Matlab R2016B, you can finally include subfunctions in scripts, so this trick is
%         probably no longer necessary.

%% Get inputs
switch nargin
    case 0
        x = evalin('base', 'x');
        y = evalin('base', 'y');
        z = evalin('base', 'z');
    case 3
        % nop
    otherwise
        error('dstauffman:UnexpectedNargin', 'Unexpected number of inputs: "%i"', nargin);
end

%% Actual function logic
out = x + y.^2 - z/10;

%% Save variables to workspace
if nargout == 0
    vars = who;
    for i = 1:length(vars)
        assignin('base', vars{i}, eval(vars{i}));
    end
end