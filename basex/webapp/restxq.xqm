(:~
: Database
: @author DTD Team
:)
module namespace page = 'http://basex.org/modules/web-page';

(: creates the matchhistory :)
declare
%rest:path("/init")
%rest:GET
updating function page:initGameIndex()
{
  let $db := doc("./static/matchhistory.xml")
  return
    (
      db:output(page:_redirect("/")),
      db:create("matchhistory", $db, "matchhistory.xml")
    )
  };


  (: zeigt das Spiel an :)
  declare
  %rest:path("/game/{$gameID}")
  %rest:GET
  function page:getStatic($gameID)
  {
    copy $doc := doc("./static/mancala2.xml")
    modify (
      (: replace value of node $doc/doc/xsl:stylesheet/xsl:variable[@name = 'GameState']/@select with $temp :)
    )

    return $doc
  };

  (: get gamestate :)
  declare
  %rest:path("/getspielzustand")
  %rest:GET
  function page:getGameState()
  {
    let $db := db:open("spielzustand")
    return $db
  };


  (: create new game :)
  declare
  %rest:path("/creategame")
  %rest:GET
  updating function page:createGame()
  {
    let $counter := page:_matchhistory()
    (: matchistory abfragen und inkrementieren :)
    let $currentID := page:_currentGameID()
    let $nextID := xs:integer($currentID + 1)
    (: spielzustand mit ID versehen, welche aus der matchistory rauslesen ist:)
    (: pfad muss nochmal neu angelegt werden :)
    let $path := concat("/game/", $nextID)
    let $db := page:_newGameState($nextID)


    return
      (
        insert node <match winner="0" loser="0">{$nextID}</match> as last into $counter/databases ,
        db:output(page:_redirect($path)),
        db:create(concat("game-", $nextID), $db, concat("game-", $nextID,".xml"))
      )
    };


    (: ____________________________PRIVATE FUNCTION_______________________________ :)

    declare function page:_redirect($redirect as xs:string) as element(restxq:redirect)
    {
      <restxq:redirect>{$redirect}</restxq:redirect>
      };

      declare function page:_matchhistory()
      {
        let $db := db:open("matchhistory")
        return $db
      };

      declare function page:_currentGameID() as xs:integer
      {
        let $db := page:_matchhistory()
        return xs:integer(max( $db/databases/match ))
      };

      declare function page:_newGameState($nextID){
        copy $db := doc("./static/spielstartzustand.xml")

        modify(
          replace value of node $db/spielfeld/spiel/ID with $nextID
        )
        return $db
      };

      declare function page:_getGame($gameID){
        let $temp := db:open (concat ("game-", $gameID))
        return $temp
      };


      declare updating function page:setValue($this)
      {
        replace value of node $this
        with 0
      };



      (: _____________________________DEBUG FUNCTION________________________________ :)

      (: get current gamestate :)
      declare
      %rest:path("debug/getgame/{$gameID}")
      %rest:GET
      function page:_debuggetgame($gameID)
      {
        let $db := db:open(concat ("game-", $gameID))
        return $db
      };

      (: get matchhistory db :)
      declare
      %rest:path("debug/getdb")
      %rest:GET
      function page:_debugget()
      {
        let $db := db:open("matchhistory")
        return $db
      };
