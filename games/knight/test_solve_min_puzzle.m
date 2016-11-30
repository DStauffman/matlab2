classdef test_solve_min_puzzle < matlab.unittest.TestCase %#ok<*PROP>
    
    properties
        board,
        moves,
    end
    
    methods (TestMethodSetup)
        function initialize(self)
            self.board     = repmat(PIECE_.null, 3, 5);
            self.board(1)  = PIECE_.start;
            self.board(13) = PIECE_.final;
            self.moves     = [2, -2];
        end
    end
    
    methods (Test)
        function test_min(self)
            % Min solver
            [output, moves] = evalc('solve_min_puzzle(self.board);');
            self.verifyEqual(moves, self.moves);
            expected_output_start = sprintf('%s\n%s','Initializing solver.','Solution found for cost of: 2.');
            self.verifyEqual(output(1:length(expected_output_start)), expected_output_start);
        end
        
        function test_no_solution(self)
            % Unsolvable
            board     = repmat(PIECE_.null, 2, 5);
            board(1)  = PIECE_.start;
            board(10) = PIECE_.final; %#ok<NASGU> - used in evalc command
            [output, moves] = evalc('solve_min_puzzle(board);');
            self.verifyTrue(isempty(moves));
            expected_output_start = sprintf('%s\n%s','Initializing solver.','No solution found.');
            self.verifyEqual(output(1:length(expected_output_start)), expected_output_start);
        end
        
        function test_no_final_position(self)
            % No final position
            self.board(13) = PIECE_.null;
            output = evalc('self.verifyError(@() solve_min_puzzle(self.board), ''knight:FinalPos'');');
            self.verifyEqual(output, sprintf('%s\n','Initializing solver.'));
        end
    end
end