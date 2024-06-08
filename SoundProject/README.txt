Sound-and-Visuals Synthesizer

Design Choices
The instrument was designed to provide a simple interface for playing and visualizing a sound file. 
The main intent was to create an engaging visual representation of the sound wave that reacts in 
real-time as the sound plays. The visuals are meant to mimic a simple song visualiser with alternating
transparencies and a rectangle to emphasise the datapoint on the FFT

Changes Made During Development
- Implemented a visual representation of the waveform to provide real-time feedback.
- Adjusted the sketch to use `FFT` for a detailed waveform analysis.
- Added amplitude control based on the vertical position of the mouse.
- Added pitch control based on the horizontal position of the mouse.
- Modified to play the sound only when the mouse is pressed instead of just looping infinitely
- Implemented timbre control using + and - keys.
- Instead of 512 samples im using 256 since it looks much cleaner visually.
- Added elipses at the sample points to change the aesthetic
- Made it so that Timbre factor is shown so user doesnt get lost

How to use: 
-Click mouse to play sound
-Move mouse vertically to adjust volume
-Move mouse horizontall to adjust pitch
-Press + to increase timbre and - to decrease timbre
-Press the spacebar to stop the current sound being played