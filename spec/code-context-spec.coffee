CodeContext = require '../lib/code-context'

describe 'CodeContext', ->
  beforeEach ->
    @codeContext = new CodeContext('test.txt', '/tmp/test.txt', null)

  describe 'fileColonLine when lineNumber is not set', ->
    it 'returns the full filepath when fullPath is truthy', ->
      expect(@codeContext.fileColonLine()).toMatch("/tmp/test.txt");
      expect(@codeContext.fileColonLine(true)).toMatch("/tmp/test.txt");

    it 'returns only the filename and line number when fullPath is falsy', ->
      expect(@codeContext.fileColonLine(false)).toMatch("test.txt");

  describe 'fileColonLine when lineNumber is set', ->
    it 'returns the full filepath when fullPath is truthy', ->
      @codeContext.lineNumber = 42
      expect(@codeContext.fileColonLine()).toMatch("/tmp/test.txt");
      expect(@codeContext.fileColonLine(true)).toMatch("/tmp/test.txt");

    it 'returns only the filename and line number when fullPath is falsy', ->
      @codeContext.lineNumber = 42
      expect(@codeContext.fileColonLine(false)).toMatch("test.txt");

  describe 'getCode', ->
    it 'returns undefined if no textSource is available', ->
      expect(@codeContext.getCode()).toBe(undefined)

    it 'returns the text from the textSource when available', ->
      # TODO: Test using an actual editor or a selection?
      dummyTextSource = {}
      dummyTextSource.getText = ->
        "print 'hello world!'"
      @codeContext.textSource = dummyTextSource
      code = @codeContext.getCode()

      expect(typeof code).toEqual('string')
      expect(code).toMatch("print 'hello world!'")