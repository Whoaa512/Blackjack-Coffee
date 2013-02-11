class window.Card extends Backbone.Model
  defaults:
    suit     : null
    value    : null
    cardID   : null
    faceDown : null
    dealt    : false

class window.Deck extends Backbone.Collection
  # generate whole deck and pull cards randomly
  model: Card

  initialize: ->
    suits  = ['spades', 'hearts', 'diams', 'clubs']
    values = [1..13]
    for suit in suits
      for value in values
        @add new Card {value, suit, cardID: "#{suit}#{value}"}

  dealCard: ->
    randomIndex = Math.floor Math.random() * 52
    thisCard = @models[randomIndex]
    if !thisCard.get 'dealt'
      @models[randomIndex].set 'dealt', true
      @models[randomIndex]
    else
      @dealCard()

# class window.Chip extends Backbone.Model

class window.Player extends Backbone.Model
  defaults:
    name      : null
    isTurn    : false
    hasPlayed : false
    isDealer  : false
    hand      : []

  getHandFrom: (deck) ->
    for i in [1..2]
      deck.dealCard()

  hit: (deck) ->
    # is not gon be nice
    @get('hand').push deck.dealCard()
    @calculateScore()

  stand: ->
    @set 'isTurn', false
    @set 'hasPlayed', true

  calculateScore: =>
    score = @.score = 0
    for card in @get 'hand'
      cardValue = card.get 'value'
      # Handle aces
      if cardValue >= 11 then cardValue = 10
      if cardValue is 1 and (@score + cardValue) < 21 then cardValue = 11
      # Handle face cards
      @score += cardValue



class window.Blackjack extends Backbone.Model
  defaults:
    players  : []
  # generate players, new deck, track each player score, track dealer score
  initialize: ->
    #TODO: create subclasses of Player model--one for dealer, one for hotseat
    #move some of this logic into those subclasses
    @.gameDeck = new Deck()
    dealer = new Player({name: 'dealer'})
    dealer.set 'isDealer', true
    player = new Player({name: 'player'})
    player.set 'isTurn', true
    dealer.set 'hand', dealer.getHandFrom @gameDeck
    player.set 'hand', player.getHandFrom @gameDeck
    # debugger
    @set 'players', [dealer, player]









