class window.BlackjackView extends Backbone.View
  CARDS: 
    1  : 'A'   
    11 : 'J'
    12 : 'Q'
    13 : 'K'
    14 : ".-~=`^___^`;=~-."

  events:
    "click .hit-button": "hit"
    "click .stand-button": "stand"
    "click .reset-button": "reset"

  render: (player) ->
    cardDiv  = ".#{player.get "name"}-cards"
    scoreDiv = ".#{player.get "name"}-score"
    # Clears player card areas
    $(cardDiv).html ''
    for card, i in player.get 'hand'
      # TODO: Re-render on turn change so this gets exposed once it's the dealer's turn
      if player.get('isDealer') and i is 1 and !player.get('isTurn')
        $(cardDiv).append "<div class='card'>LOLZ NO</div>"
      cardClass = card.get 'suit'
      # Coerce into a strizzing
      cardSuit  = card.get 'suit'
      cardRank = '' + (@CARDS[card.get 'value'] or card.get 'value')
      switch cardRank
        when '1' then cardRank =  'A'
        when '11' then cardRank = 'J'
        when '12' then cardRank = 'Q'
        when '13' then cardRank = 'K'
        else cardRank = cardRank
      $(cardDiv).append "<div class='card #{cardClass}'><span class='rank'>#{cardRank}</span><span class='suit'>&#{cardSuit};</span></div>"
    $(scoreDiv).html player.score


  initialize: ->
    @reset()

  reset: ->
    # returns array of all players & dealer
    theGame = new Blackjack()
    @.players = theGame.get 'players'
    @.gameDeck = theGame.gameDeck
    # Inserts player cards
    for player in @players
      player.calculateScore()
      @render player
    @players

  hit: ->
    ## Access that new Blackjack thing up thurr
    ## check players, see whose turn it is
    ## give that guy the card
    for player in @players
      if player.get 'isTurn'
        player.hit(@gameDeck)
        player.calculateScore()
        @render player
    # call deck.dealCard
    # after, check score

  stand: ->
    for player in @players
      if player.get 'isTurn'
        player.stand()
      else if player.get 'hasPlayed' is false
        player.set 'isTurn', true

    # pass control to dealer
    # reveal dealer down card
    # dealer hit until handscore >= 17


# class window.CardView extends Backbone.View
#   el        : 'span'
#   className : 'cardView'

#   render: (card) ->
#     $(this.el).html card.get 'cardID'


# handView to display both cards

#



# get('name') + '-cards'





