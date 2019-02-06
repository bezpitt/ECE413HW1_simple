function [soundOut] = create_chord( chordType,temperament, root, constants )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [ soundOut ] = create_scale( chordType,temperament, root, constants )
% 
% This function creates the sound output given the desired type of chord
%
% OUTPUTS
%   soundOut = The output sound vector
%
% INPUTS
%   chordType = Must support 'Major' and 'Minor' at a minimum
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


switch chordType
    case {'Major','major','M','Maj','maj'}
        Playthese = [1 0 0 0 1 0 0 1 0 0 0 0];
    case {'Minor','minor','m','Min','min'}
        Playthese = [1 0 0 1 0 0 0 1 0 0 0 0];
    case {'Power','power','pow'}
        Playthese = [1 0 0 0 0 1 0 0 0 0 0 0];
    case {'Sus2','sus2','s2','S2'}
        Playthese = [1 0 1 0 0 0 0 1 0 0 0 0];
    case {'Sus4','sus4','s4','S4'}
        Playthese = [1 0 0 0 0 1 0 1 0 0 0 0];
    case {'Dom7','dom7','Dominant7', '7'}
        Playthese = [1 0 0 0 1 0 0 1 0 0 1 0];
    case {'Min7','min7','Minor7', 'm7'}
        Playthese = [1 0 0 1 0 0 0 1 0 0 1 0];
    otherwise
        error('Inproper chord specified');
end

switch temperament
    case {'just','Just'}
        ratio = [1 16/15 9/8 6/5 5/4 4/3 45/32 3/2 8/5 5/3 9/5 15/8];
        bigratio = [ratio/16 ratio/8 ratio/4 ratio/2 ratio 2*ratio 4*ratio 8*ratio];%A0 to G#7
    case {'equal','Equal'}
        list = 0:11;
        ratio = constants.holyconstantofmusic.^list;
        bigratio = [ratio/16 ratio/8 ratio/4 ratio/2 ratio 2*ratio 4*ratio 8*ratio];%A0 to G#7
    otherwise
        error('Inproper temperament specified')
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
freqlist = startnote .* ratio .* Playthese;
w = 2*pi*freqlist;
Length = constants.fs * constants.durationChord;
t = linspace(0, constants.durationChord, Length);
[W, T] = meshgrid(w,t);
Mult = W.*T;
signs = sin(Mult);
soundOut = sum(signs,2);
end
