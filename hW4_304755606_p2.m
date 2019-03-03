%Problem 2 DNA Analysis
%David Curry
%ID: 304755606
clear all;
clc;
%define initial condtions
load('chr1_sect.mat');
numBases = length(dna);
startpoint = 0;
numProteins = 0; 
numCodon1 = 0;
numCodon2 = 0;
numCodon3 = 0;
LENGTH = zeros(1,numProteins);
%loop thru the entire dna
for k = 1:3:numBases - 2 
    %check if startpoint has been fixed
    if startpoint == 0
        if dna(k) == 1 && dna(k+1) == 4 && dna(k+2) == 3
            startpoint = k;
        end
    else %if startpoint has been established, it finds the endpoint
        if (dna(k)==4 && dna(k+1)==1 && dna(k+2)==1)||(dna(k)==4 && dna(k+1)==1 && dna(k+2)==3)||(dna(k)==4 && dna(k+1)==3 &&dna(k+2)==1)
            length = k - startpoint + 3;
            numProteins = numProteins + 1;
            %puts the length of this specific protein in the next slot in 
            %the array LENGTH
            LENGTH(numProteins) = length;
            %resets startpoint
            startpoint = 0;
            if dna(k)==4 && dna(k+1)==1 && dna(k+2)==1
                numCodon1 = numCodon1 + 1 ;
            elseif dna(k)==4 && dna(k+1)==1 && dna(k+2)==3
                numCodon2 = numCodon2 + 1;
            else 
                numCodon3 = numCodon3 + 1;
            end
        end
    end
end
%find the average, maximum, and minimum of the protein lengths
avg = mean(LENGTH);
maxim = max(LENGTH);
minim = min(LENGTH);
%print out the data
fprintf('Total Protein Coding segments: %.0f\n',numProteins);
fprintf('Average Length: %.2f\n', avg);
fprintf('Maximum Length: %.0f\n', maxim);
fprintf('Minimum Length: %.0f\n', minim);

percent = sum(LENGTH)/numBases ;        
