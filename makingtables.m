root = "A4";
temperament = "Equal";
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
if(isempty(octavechooser))
    octavechooser = 4;
end

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
freqlist = (startnote .* ratio)'