
% Student: Emre Besler
% Image ID: Number of your selected image in the provided folder 'Player_Images'
% Section:  30
% Date:     11/11/2016

% **************************
% LAB PROJECT
% **************************
%% Initialization
clear; close all; clc

imagePath = ['.', filesep(), 'Player_Images', filesep()];

playerNumber = 1;  % You should use your picked image after you
                    % identify it in the Player_Images folder

playerImage = [imagePath, 'player', num2str(playerNumber), '.png'];
if ~exist(playerImage,'file')
    error('Query image does not exist... Please select a playerNumber between 1 and 100.');
end

%% Create and Unscramble Image Database

if ~exist('imageDatabases.mat','file')
    
    % Create Scrambled Image Database
    fprintf(2,'Constructing Image Database...\n');
    scrambledDatabase = createImageDatabase(imagePath);
    fprintf('Done!\n\n');
    
    % Unscramble the Database
    fprintf(2,'Unscrambling the Image Database...\n');
    [correctDatabase,scrambledIndices] = unScrambleDatabase(imagePath,scrambledDatabase);
    fprintf('Done!\n\n');
    
    % Verify that the Database has been Unscrambled
    fprintf(2,'Verifying that the Image Database is corrected...\n');
    [~,correctIndices] = unScrambleDatabase(imagePath,correctDatabase);
    if exist('calcMSE','file')
        if calcMSE(correctIndices,1:length(correctIndices)) == 0
            % If database has been corrected store the results so you don't
            % have to rerun the unscrambling code every time.
            save('imageDatabases.mat','scrambledDatabase','correctDatabase','scrambledIndices','correctIndices');
            warningFlag = false;
            fprintf('Done!\n\n');
        else
            warningFlag = true;
            warning('Image Database was not properly unscrambled');
            fprintf('\n');
        end
    else
        warning('Successful unscrambling cannot be currently evaluated... Create "calcMSE" function first');
        fprintf('\n');
    end
else
    fprintf(2,'Correct Database is already stored in a file... Loading...\n');
    scrambledDatabase  = load('imageDatabases.mat','scrambledDatabase');
    scrambledDatabase  = scrambledDatabase.scrambledDatabase;
    correctDatabase    = load('imageDatabases.mat','correctDatabase');
    correctDatabase    = correctDatabase.correctDatabase;
    scrambledIndices   = load('imageDatabases.mat','scrambledIndices');
    scrambledIndices   = scrambledIndices.scrambledIndices;
    correctIndices     = load('imageDatabases.mat','correctIndices');
    correctIndices     = correctIndices.correctIndices;
    fprintf('Done!\n\n');
end


% If unScrambling was performed correctly show the indices before and after
% unScrambling
if exist('plotIndices','file')
    plotIndices(scrambledIndices,correctIndices)
else
    warning('Indices cannot be currently plotted... Create "plotIndices" function first.');
    fprintf('\n');
end


%% Checking if you can identify yourself in the database

% Read Image to be Found (will work only after you create the readImage
% function
if exist('readImage','file')
    x = readImage(playerImage);
else
    x = [];
end

% First check your identity using the scrambled database
fprintf(2,'Checking Player Identity in the Scrambled Database...\n'); pause(0.2);
if exist('findMinimumErrorPosition','file') && exist('computePSNRs','file')
    identificationFlag = true;
    minPos = findMinimumErrorPosition(makeVector(x),scrambledDatabase);
    PSNRs  = computePSNRs(makeVector(x),scrambledDatabase);
else
    identificationFlag = false;
end

if identificationFlag
    playerName = identifyPlayer(x,imagePath,minPos,PSNRs);
    fprintf('Player identified as %s at the Scrambled Database column: %d!\n\n', playerName, minPos);
    pause(0.2);
else
    warning('Players cannot be currently identified in the Scrambled Database... Create "findMinimumErrorPosition" and "computePSNRs" functions first.');
    fprintf('\n');
end

% Then check your identity again using the correct database
fprintf(2,'Checking Player Identity in the Corrected Database...\n'); pause(0.2);
if exist('findMinimumErrorPosition','file') && exist('computePSNRs','file')
    identificationFlag = true;
    minPos = findMinimumErrorPosition(makeVector(x),correctDatabase);
    PSNRs  = computePSNRs(makeVector(x),correctDatabase);
else
    identificationFlag = false;
end

if identificationFlag
    PlayerName = identifyPlayer(x,imagePath,minPos,PSNRs);
    fprintf('Player identified as %s at the Corrected Database column: %d!\n\n', PlayerName, minPos);
    pause(0.2);
else
    warning('Players cannot be currently identified in the Corrected Database... Create "findMinimumErrorPosition" and "computePSNRs" functions first.');
    fprintf('\n');
end
