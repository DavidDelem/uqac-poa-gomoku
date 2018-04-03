package aspects;

import gomoku.core.Player;
import javafx.scene.paint.Color;

/* --------------------------------------------------------------------------------------   */
/* David Delemotte - Rénald Morice                                                          */
/* Aspect permettant le support de 2 joueurs au lieu d'un seul                              */
/* --------------------------------------------------------------------------------------   */

public aspect AdversaireJ {

    private Player player1 = new Player("Mr. Blue", Color.BLUE);
    private Player player2 = new Player("Mr. Red", Color.RED);
    private Player currentPlayer;

    /* --------------------------------------------------------------------------------------   */
    /* Interception de la valeur de retour de la méthode getCurrentPlayer                       */
    /* Modification du retour pour qu'elle renvoie un des deux joueur contenu de l'aspect       */
    /* A chaque tour, on inverse le currentPlayer                                               */
    /* --------------------------------------------------------------------------------------   */

    pointcut changeCurrentPlayer() : execution(Player getCurrentPlayer());

    Player around() : changeCurrentPlayer() {

        if(currentPlayer == null) {
            // au premier tour, le joueur courant est le joueur 1
            currentPlayer = this.player1;
        } else if(currentPlayer == player1) {
            // on inverse le joueur
            currentPlayer = player2;
        } else if(currentPlayer == player2) {
            // on inverse le joueur
            currentPlayer = player1;
        }

        // on renvoie le bon joueur
        return currentPlayer;
    }

}
