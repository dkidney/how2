from IPython.display import Audio
import numpy as np

def beep(freq=440, duration=0.1):
  """Generates a beep sound in an ipython notebook."""
  sr = 44100
  t = np.linspace(0, duration, int(sr * duration), endpoint=False)
  tone = np.sin(2 * np.pi * freq * t)
  audio = Audio(tone, rate=sr, autoplay=True)
  return audio
