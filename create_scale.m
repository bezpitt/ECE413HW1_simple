function [soundOut] = create_scale( scaleType,temperament, root, constants )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [ soundOut ] = create_scale( scaleType,temperament, root, constants )
% 
% This function creates the sound output given the desired type of scale
%
% OUTPUTS
%   soundOut = The output sound vector
%
% INPUTS
%   scaleType = Must support 'Major' and 'Minor' at a minimum
%   temperament = may be 'just' or 'equal'
%   root = The Base frequeny (expressed as a letter followed by a number
%       where A4 = 440 (the A above middle C)
%       See http://en.wikipedia.org/wiki/Piano_key_frequencies for note
%       numbers and frequencies
%   constants = the constants structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TODO: Add all relavant constants 

switch scaleType
    case {'Major','major','M','Maj','maj'}
	% TODO: Complete with interval pattern for the major scale
    Playthese = [1 0 1 0 1 1 0 1 0 1 0 1];
    case {'Minor','minor','m','Min','min'}
	% TODO: Complete with interval pattern for the minor scale
    Playthese = [1 0 1 1 0 1 0 1 1 0 1 0];
    case {'Harmonic', 'harmonic', 'Harm', 'harm'}
	% EXTRA CREDIT
    Playthese = [1 0 1 1 0 1 0 1 1 0 0 1];
    %case {'Melodic', 'melodic', 'Mel', 'mel'}
	% EXTRA CREDIT
    otherwise
        error('Improper scale specified');
end

switch temperament
    case {'just','Just'}
	% TODO: Pull the Just tempered ratios based on the pattern from the scales
        ratio = [1 16/15 9/8 6/5 5/4 4/3 45/32 3/2 8/5 5/3 9/5 15/8];
        bigratio = [ratio/16 ratio/8 ratio/4 ratio/2 ratio 2*ratio 4*ratio 8*ratio];%A0 to G#7
    case {'equal','Equal'}
	% TODO: Pull the equal tempered ratios based on the pattern from the scales
        list = 0:11;
        ratio = constants.holyconstantofmusic.^list;
        bigratio = [ratio/16 ratio/8 ratio/4 ratio/2 ratio 2*ratio 4*ratio 8*ratio];%A0 to G#7
    otherwise
        error('Improper temperament specified')
end

[notechooser,octavechooser] = split(root, ["0", "1", "2", "3", "4", "5", "6", "7"]);
%{
I couldn't get both default A being A4 and regular A4 working
if(isempty(octavechooser))
    octavechooser = 4;
end
%}

switch notechooser{1,1}
    case {'A'}
        index = 1 + 12*str2double(octavechooser);
    case {'A#', 'Bb'}
        index = 2 + 12*str2double(octavechooser);
    case {'B'}
        index = 3 + 12*str2double(octavechooser);
    case {'C'}
        index = 4 + 12*(str2double(octavechooser)-1);
    case {'C#', 'Db'}
        index = 5 + 12*(str2double(octavechooser)-1);
    case {'D'}
        index = 6 + 12*(str2double(octavechooser)-1);
    case {'D#', 'Eb'}
        index = 7 + 12*(str2double(octavechooser)-1);
    case {'E'}
        index = 8 + 12*(str2double(octavechooser)-1);
    case {'F'}
        index = 9 + 12*(str2double(octavechooser)-1);
    case {'F#', 'Gb'}
        index = 10 + 12*(str2double(octavechooser)-1);
    case {'G'}
        index = 11 + 12*(str2double(octavechooser)-1);
    case {'G#', 'Ab'}
        index = 12 + 12*(str2double(octavechooser)-1);
    otherwise
        error("Invalid root note");
end

startnote = 440 * bigratio(index);
Logic = ratio(:,logical(Playthese));
freqlist = startnote .* Logic;% .* Playthese;
%freqlist = find(freqlist > 0);
w = 2*pi*freqlist;
Length = constants.fs * constants.durationScale;
t = linspace(0, constants.durationScale, Length);
[W, T] = meshgrid(w,t);
Mult = W.*T;
%Decay Matrix adds decay to make transition between notes sound nice.
decay = sin(t*2*pi*(2*constants.durationScale)^-1 )';
decayMatrix = repmat(decay,1,length(Logic));

signs = sin(Mult) .* decayMatrix;

soundOut = reshape(signs,[],1);
end
