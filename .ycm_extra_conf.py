flags = [
  "--Wall"
]

def FlagsForFile(filename, **kwargs):
  return {
    'flags': flags,
    'do_cache': True
  }
