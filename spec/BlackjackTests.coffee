describe "Deck Collection", ->
  testDeck = null
  beforeEach ->
    testDeck = new Deck()
  
  it "should have array of 52 objects", ->
    expect(testDeck.length).toBe(52)

  it "should not contain duplicate items", ->
    testHash = {}
    for card in testDeck.models
      holder = "#{card.get 'suit'}#{card.get 'value'}"
      testHash[holder] = holder
    expect(_.size(testHash)).toBe(52)

  describe "dealCard method", ->
    it "should be a function", ->
      expect(typeof testDeck.dealCard).toBe('function')

    it "should deal a random card", ->
      someDeck = []
      dealtCard = testDeck.dealCard()
      for card in testDeck.models
        someDeck.push card.get 'cardID'

      isInSomeDeck = false
      for card in someDeck
        if dealtCard.get('cardID') is card
          isInSomeDeck = true

      expect(isInSomeDeck).toBe(true)

    it 'should mark a card as dealt after dealing', ->
      testCard = testDeck.dealCard()
      expect(testCard.get 'dealt').toBeTruthy()
      falseCounter = 0
      for card in testDeck.models
        if !card.get 'dealt'
          falseCounter++
      expect(falseCounter).toBe(51)


describe 'Player Model', ->
  testPlayer = testDeck = null
  beforeEach ->
    testDeck = new Deck()
    testPlayer = new Player()
    testPlayer.set 'hand', testPlayer.getHandFrom testDeck


  it "should create a player that has two cards in its hand", ->
    expect(testPlayer.get('hand').length).toBe(2)

  describe 'Hit method', ->
    it 'should add a card to players hand', ->
      expect(testPlayer.get('hand').length).toBe(2)
      testPlayer.hit(testDeck)
      expect(testPlayer.get('hand').length).toBe(3)








