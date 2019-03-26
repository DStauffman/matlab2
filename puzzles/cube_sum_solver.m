%% Given:
A      = [0 0 0 2; 0 8 0 0; 9 0 0 0; 0 0 7 0];
horzs  = [13; 31; 13; 25];
verts  = [33; 13; 14; 22];
diags  = [26; 15];
A_soln = [8 2 1 2; 9 8 5 9; 9 1 1 2; 7 2 7 9];

%% settings
max_iters = 10;
round_dig = 4;

%% enforce consistency
horzs = horzs(:);
verts = verts(:);
diags = diags(:);

%% alias useful values
n    = size(A, 1);
d1   = sub2ind([n n], 1:n, 1:n)';
d2   = sub2ind([n n], 1:n, n:-1:1)';
mask = A == 0;

%% calculations
% initialize working solution
R = A;
% loop through iterative solver
for it = 1:max_iters
    % horizontals
    delta_h = horzs - sum(R, 2);
    R = R + mask .* round(delta_h ./ sum(mask, 2), round_dig);

    % verticals
    delta_v = verts - sum(R,1)';
    R = R + mask .* round((delta_v ./ sum(mask, 1))', round_dig);

    % diag one
    delta_d1 = diags(1) - sum(R(d1));
    temp = zeros(n, n);
    temp(d1) = round(delta_d1 ./ sum(mask(d1)), round_dig);
    R = R + mask .* temp;

    % diag two
    delta_d2 = diags(2) - sum(R(d2));
    temp = zeros(n, n);
    temp(d2) = round(delta_d2 ./ sum(mask(d2)), round_dig);
    R = R + mask .* temp;

    % enforce minimum and maximum constraints
    R = enforce_minmax(R);

    % check if done, and if so display results and exit solver loop
    if is_done(round(R), horzs, verts, diags, d1, d2)
        R = round(R);
        disp(['Done on iteration: ', int2str(it)]);
        print_sums(R, horzs, verts, diags, d1, d2);
        break
    end
    if it == max_iters
        % check if not done after reaching final iteration
        disp('No exact solution found');
        R = round(R);
    end
    % display the current results
    disp(['Results after iteration: ', int2str(it)]);
    print_sums(R, horzs, verts, diags, d1, d2);
end


%% Subfunctions - is_done
function [out] = is_done(A, h, v, d, d1, d2)
    % checks if the solution has been found
    temp = (sum(A, 2) == h) & (sum(A, 1)' == v) & (sum(A(d1)) == d(1)) & (sum(A(d2)) == d(2));
    if all(all(temp))
        out = true;
    else
        out = false;
    end
end


%% Subfunctions - print_sums
function print_sums(A, h, v, d, d1, d2)
    % displays information about the current solution compared to the desired one
    disp('A = ');
    disp(A);
    fprintf('Row sums    = [%g %g %g %g], Want: [%g %g %g %g], Error: [%g %g %g %g]\n',sum(A, 2), h, h-sum(A, 2));
    fprintf('Column sums = [%g %g %g %g], Want: [%g %g %g %g], Error: [%g %g %g %g]\n',sum(A, 1)', v, v-sum(A, 1)');
    t = [sum(A(d1)); sum(A(d2))];
    fprintf('Diag sums   = [%g %g], Want: [%g %g], Error: [%g %g]\n',t, d, d-t);
end


%% Subfunctions - enforce_minmax
function [out] = enforce_minmax(A)
    % enforces and minimum and maximum constraint
    out = max(min(A, 9), 1);
end