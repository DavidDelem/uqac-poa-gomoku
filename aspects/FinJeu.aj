package aspects;

import gomoku.core.Player;
import gomoku.core.model.Spot;
import gomoku.core.model.Grid;
import javafx.geometry.Rectangle2D;
import javafx.scene.Scene;
import javafx.scene.layout.VBox;
import javafx.scene.paint.Color;
import javafx.scene.shape.Circle;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.scene.text.TextAlignment;
import javafx.stage.Modality;
import javafx.stage.Screen;
import javafx.stage.Stage;

import java.lang.reflect.Field;
import java.util.List;

/* --------------------------------------------------------------------------------------   */
/* David Delemotte - Rénald Morice                                                          */
/* Aspect permettant de gérer la fin du jeu                                                 */
/* --------------------------------------------------------------------------------------   */

public aspect FinJeu {

    private boolean partieTerminee = false;

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut permettant de capturer les mouvements                                           */
    /* --------------------------------------------------------------------------------------   */

    pointcut captureMakeMove(Spot place) :
            execution(void makeMove(Spot)) &&
                    args(place);

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut permettant de capturer la fin du jeu                                            */
    /* --------------------------------------------------------------------------------------   */

    pointcut captureGameOver(Player winner) :
            call(void gameOver(Player)) &&
                    args(winner);

    /* --------------------------------------------------------------------------------------   */
    /* Fonction liée au pointcut captureMaleMove qui bloque lesmouvements après la fin du jeu   */
    /* --------------------------------------------------------------------------------------   */

    void around(Spot place) : captureMakeMove(place) {
        if(!partieTerminee) {
            // on laisse la méthode continuer uniquement si la partie n'est pas terminée
            proceed(place);
        } else {
            // la partie est terminée, on bloque le mouvement en ne faisant pas de proceed et on affiche un message
            // ne pas faire de proceed dans un around = bloquer la méthode
            System.out.println("Impossible de jouer, la partie est terminée.");
        }
    }

    /* --------------------------------------------------------------------------------------   */
    /* Fonction liée au pointcut captureGameOver pour afficher legagnant dans une fenêtre       */
    /* --------------------------------------------------------------------------------------   */

    after(Player winner) : captureGameOver(winner) {

        partieTerminee = true;

        Rectangle2D primaryScreenBounds = Screen.getPrimary().getVisualBounds();

        /* Cercle de la couleur du gagnant */
        Circle circle = new Circle();
        circle.setRadius(150.0f);
        circle.setFill(winner.getColor());

        /* Texte annonçant le gagnant */
        Text text = new Text("Fin du jeu !\nLe gagnant est " + winner.getName());
        text.setFont(Font.font ("Georgia", 28));
        text.setFill(winner.getColor());
        text.setTextAlignment(TextAlignment.CENTER);

        /* Fenêtre et positionnement */
        final Stage dialog = new Stage();
        dialog.setX(primaryScreenBounds.getWidth() / 2 + 170);
        dialog.setY(primaryScreenBounds.getHeight() / 2 - 180);
        dialog.initModality(Modality.APPLICATION_MODAL);

        /* Ajout du contenu de la fenêtre */
        VBox dialogVbox = new VBox(20);
        dialogVbox.getChildren().add(text);
        dialogVbox.getChildren().add(circle);

        /* Affichage final */
        Scene dialogScene = new Scene(dialogVbox, 300, 130);
        dialog.setScene(dialogScene);
        dialog.show();
    }

}
