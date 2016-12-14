function [OPTIONS] = create_options()

% CREATE_OPTIONS  creates the default options, and serves as guide for the possible values
%
% Input:
%     None
%
% Output:
%     OPTIONS ............... : (struct) game options
%         .load_previous_game : (scalar) true/false flag specifying whether to load the previous game [bool]
%         .name_white ....... : (row) string specifying the name of the white player [char]
%         .name_black ....... : (row) string specifying the name of the black player [char]
%         .plot_winning_moves : (scalar) true/false flag specifying whether to plot winning moves on the board [bool]
%
% Prototype:
%     OPTIONS = create_options();
%
% Change Log:
%     1.  Written by David C. Stauffer in Jan 2010.

% load previous game
opt = cell(3,1);
opt{1} = 'Yes';
opt{2} = 'No';
opt{3} = 'Ask';
OPTIONS.load_previous_game = opt{1};

% player names
OPTIONS.name_white = 'Player 1';
OPTIONS.name_black = 'Player 2';

% winning moves
OPTIONS.plot_winning_moves = true;

% save options for later
save('options.mat','OPTIONS');