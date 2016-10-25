% EA 1, Homework program assignment 3
%
% Name: Michael Hsu
% Section: 30
% Date: 10/6/2016

betArray = [];
budgetArray = [];

raceNum = 0;
gameOver = false;
N = input('Number of contestants: ');
budget = input('Enter a budget: $');
% Step 1
while(true)
    if size(budget,2) > 1
        disp('Enter in a number, not an array.');
    else
        if(budget >= 1)
            break;
        else
            disp('Please make sure the budget is at least the minimum bet of 1.');
        end
    end
end
rerun = true;
while(rerun == true)
    raceNum = raceNum + 1;
    fprintf('Race %1.0f\n', raceNum);
    cap = budget * 2;

    % Step 2: Generate mean time Tn for contestant n
    Tn = (rand(1,N)*2) + 1;
    
    % Step 3: Payouts
    payout = zeros(size(Tn));
    for ii = 1:N
    summation = 0;
        for jj = 1:N
            summation = summation + 1/Tn(jj);
        end
        Pn = (1/Tn(ii)) / summation;
        payout(ii) = 1/Pn;
    end

    % Step 4
    disp('Contestant odds:')
    disp(payout)
    x = false;
    while(x == false)
        bets = input('Place bets: ');
        if ismatrix(bets)
            if size(bets,2) == N
                if sum(bets) <= budget
                    for ii = 1:size(bets,2)
                        if bets(ii) < 0
                            disp('No negative numbers!');
                            break;
                        else
                            x = true;
                            break;
                        end
                    end
                else
                    disp('You went over budget!');
                end
            else
                disp('Make sure you match the number of contestants!');
            end
        else
            disp('Enter in a matrix with brackets');
        end
    end

    % Step 5
    randa = random('exp',Tn);
    disp('Times:')
    disp(randa);
   
    for ii = 1:size(randa,2)
        if randa(ii) == min(randa)
            index = ii;
            fprintf('The winner is contestant number %1.0f!\n', ii);
            break
        end
    end

    % Step 6
    budget = budget - sum(bets);
    gain = payout(index) * bets(index);
    budget = budget + gain;
    
    % step 7
    if budget <= 1
        disp('Game over! You ran out of money.');
        gameOver = false;
        break;
    else
        if budget > cap 
            disp('Congratulations! You have exceeded the cap!');
            betArray = [betArray sum(bets)];
            budgetArray = [budgetArray budget];
            break;
        end
        fprintf('Your budget is $%1.2f\n', budget);
        rerun = input('Continue playing? (1-y) (0-n) ');
        if rerun == 1
            betArray = [betArray sum(bets)];
            budgetArray = [budgetArray budget];
            
        else
            betArray = [betArray sum(bets)];
            budgetArray = [budgetArray budget];
            break;
        end
    end
end

for ii = 1:raceNum
   fprintf('Race %1.0f: bet $%1.2f, budget $%1.2f \n',ii,betArray(ii),budgetArray(ii)); 
end

% 1. Budget drops below one, the minimum bet
% Number of contestants: 4
% Enter a budget: $10
% Race 1
% Contestant odds:
%    39.0055    1.2616   21.5551    7.3886
% 
% Place bets: [5 0 5 0]
% Times:
%     0.0573    0.0291    1.0173    0.3792
% 
% The winner is contestant number 2!
% Game over! You ran out of money.

% 2. Budget exceeds cap
% Your budget is $5.74
% Continue playing? (1-y) (0-n) 1
% Race 5
% Contestant odds:
%     8.5212   19.1241    6.4259    1.4821
% 
% Place bets: [1 0 0 0]
% Times:
%     0.0335    1.4345    0.4898    0.1019
% 
% The winner is contestant number 1!
% Congratulations! You have exceeded the cap!
% Your budget is $13.26
% Race 1: bet $17, budget $6.36
% Race 2: bet $4, budget $9.04
% Race 3: bet $6, budget $7.06
% Race 4: bet $5, budget $5.74
% Race 5: bet $1, budget $13.26

% 3. Terminate program by choosing not to continue and entered the first
% bets incorrectly
% Number of contestants: 4
% Enter a budget: $10
% Race 1
% Contestant odds:
%     4.9777   10.0504    1.5847   14.5847
% 
% Place bets: [-1 3 1 3]
% No negative numbers!
% Place bets: [1 1 1 1]
% Times:
%     0.5830    1.8764    0.2663    0.1560
% 
% The winner is contestant number 4!
% Congratulations! You have exceeded the cap!
% Your budget is $20.58
% Continue playing? (1-y) (0-n) 0
% Race 1: bet $4, budget $20.58