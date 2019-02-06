%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCRIPT
%    hw1
% 
% This script runs questions 2 through 4 of the HW1 from ECE313:Music and
% Engineering.
%
% This script was adapted from hw1 recevied in 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear functions
clear variables
%dbstop if error


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
constants.fs=44100;                 % Sampling rate in samples per second
constants.durationScale=0.5;        % Duration of notes in a scale
constants.durationChord=3;          % Duration of chords
constants.holyconstantofmusic = 2^(1/12); %Used for equal temperament



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2 - scales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[soundMajorScaleJust]=create_scale('Major','Just','A4',constants);
[soundMajorScaleEqual]=create_scale('Major','Equal','A4',constants);
[soundMinorScaleJust]=create_scale('Minor','Just','A4',constants);
[soundMinorScaleEqual]=create_scale('Minor','Equal','A4',constants);

disp('Playing the Just Tempered Major Scale');
soundsc(soundMajorScaleJust,constants.fs);
pause(constants.durationScale * 7);
disp('Playing the Equal Tempered Major Scale');
soundsc(soundMajorScaleEqual,constants.fs);
pause(constants.durationScale * 7);

disp('Playing the Just Tempered Minor Scale');
soundsc(soundMinorScaleJust,constants.fs);
pause(constants.durationScale * 7);

disp('Playing the Equal Tempered Minor Scale');
soundsc(soundMinorScaleEqual,constants.fs);
pause(constants.durationScale * 7);

fprintf('\n');

% EXTRA CREDIT - Melodic and Harmonic scales
[soundHarmScaleJust]=create_scale('Harmonic','Just','A4',constants);
[soundHarmScaleEqual]=create_scale('Harmonic','Equal','A4',constants);
%{
[soundMelScaleJust]=create_scale('Melodic','Just','A',constants);
[soundMelScaleEqual]=create_scale('Melodic','Equal','A',constants);
%}

disp('Playing the Just Tempered Harmonic Scale');
soundsc(soundHarmScaleJust,constants.fs);
pause(constants.durationScale * 7);

disp('Playing the Equal Tempered Harmonic Scale');
soundsc(soundHarmScaleEqual,constants.fs);
pause(constants.durationScale * 7);

%{
disp('Playing the Just Tempered Melodic Scale');
soundsc(soundMelScaleJust,constants.fs);
disp('Playing the Equal Tempered Melodic Scale');
soundsc(soundMelScaleEqual,constants.fs);
%}
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3 - chords
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fund = 'A4'; % need this to determine wavelength for plots

% major and minor chords
[soundMajorChordJust]=create_chord('Major','Just',fund,constants);
[soundMajorChordEqual]=create_chord('Major','Equal',fund,constants);
[soundMinorChordJust]=create_chord('Minor','Just',fund,constants);
[soundMinorChordEqual]=create_chord('Minor','Equal',fund,constants);

disp('Playing the Just Tempered Major Chord');
soundsc(soundMajorChordJust,constants.fs);
pause(constants.durationChord);

disp('Playing the Equal Tempered Major Chord');
soundsc(soundMajorChordEqual,constants.fs);
pause(constants.durationChord);

disp('Playing the Just Tempered Minor Chord');
soundsc(soundMinorChordJust,constants.fs);
pause(constants.durationChord);

disp('Playing the Equal Tempered Minor Chord');
soundsc(soundMinorChordEqual,constants.fs);
pause(constants.durationChord);

fprintf('\n');

% assorted other chords
[soundPowerChordJust]=create_chord('Power','Just',fund,constants);
[soundPowerChordEqual]=create_chord('Power','Equal',fund,constants);
[soundSus2ChordJust]=create_chord('Sus2','Just',fund,constants);
[soundSus2ChordEqual]=create_chord('Sus2','Equal',fund,constants);
[soundSus4ChordJust]=create_chord('Sus4','Just',fund,constants);
[soundSus4ChordEqual]=create_chord('Sus4','Equal',fund,constants);
[soundDom7ChordJust]=create_chord('Dom7','Just',fund,constants);
[soundDom7ChordEqual]=create_chord('Dom7','Equal',fund,constants);
[soundMin7ChordJust]=create_chord('Min7','Just',fund,constants);
[soundMin7ChordEqual]=create_chord('Min7','Equal',fund,constants);


disp('Playing the Just Tempered Power Chord');
soundsc(soundPowerChordJust,constants.fs);
pause(constants.durationChord);

disp('Playing the Equal Tempered Power Chord');
soundsc(soundPowerChordEqual,constants.fs);
pause(constants.durationChord);

disp('Playing the Just Tempered Sus2 Chord');
soundsc(soundSus2ChordJust,constants.fs);
pause(constants.durationChord);

disp('Playing the Equal Tempered Sus2 Chord');
soundsc(soundSus2ChordEqual,constants.fs);
pause(constants.durationChord);

disp('Playing the Just Tempered Sus4 Chord');
soundsc(soundSus2ChordJust,constants.fs);
pause(constants.durationChord);

disp('Playing the Equal Tempered Sus4 Chord');
soundsc(soundSus2ChordEqual,constants.fs);
pause(constants.durationChord);

disp('Playing the Just Tempered Dom7 Chord');
soundsc(soundDom7ChordJust,constants.fs);
pause(constants.durationChord);

disp('Playing the Equal Tempered Dom7 Chord');
soundsc(soundDom7ChordEqual,constants.fs);
pause(constants.durationChord);

disp('Playing the Just Tempered Min7 Chord');
soundsc(soundMin7ChordJust,constants.fs);
pause(constants.durationChord);

disp('Playing the Equal Tempered Min7 Chord');
soundsc(soundMin7ChordEqual,constants.fs);
pause(constants.durationChord);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4 - plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% determine fundamental frequency


% Major chords
figure;
hold on
title("A few Major Chords");
plot(soundMajorChordEqual(1:1000));
plot(soundMajorChordJust(1:1000));
xlabel("samples");
ylabel("Amplitude");
legend("Equal","Just");
hold off
%   Single Wavelength
%     just tempered
%     equal tempered
%   Tens of Wavelengths
figure;
hold on
title("A bunch of Major Chords");
plot(soundMajorChordEqual(1:2500));
plot(soundMajorChordJust(1:2500));
xlabel("samples");
ylabel("Amplitude");
legend("Equal","Just");
hold off
%     just tempered
%     equal tempered

% Minor chords
%   Single Wavelength
figure;
hold on
title("A few Minor Chords");
plot(soundMinorChordEqual(1:1000));
plot(soundMinorChordJust(1:1000));
xlabel("samples");
ylabel("Amplitude");
legend("Equal","Just");
hold off
%   Singl
%     just tempered
%     equal tempered
%   Tens of Wavelengths
figure;
hold on
title("A bunch of Minor Chords");
plot(soundMinorChordEqual(1:2500));
plot(soundMinorChordJust(1:2500));
xlabel("samples");
ylabel("Amplitude");
legend("Equal","Just");
hold off
%     just tempered
%     equal tempered
