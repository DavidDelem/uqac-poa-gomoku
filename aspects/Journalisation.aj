package aspects;

import gomoku.core.model.Grid;
import  gomoku.core.Player;

import java.io.FileWriter;
import java.io.IOException;

/* --------------------------------------------------------------------------------------   */
/* Aspect permettant de journaliser les coups joués dans un fichier                         */
/* --------------------------------------------------------------------------------------   */

public aspect Journalisation {

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut permettant de récupérer les positions et le nom du joueur lors de chaque coup   */
    /* --------------------------------------------------------------------------------------   */

    pointcut captureParametres(int x, int y, Player player) :
            call(void Grid.placeStone(int, int, Player)) &&
            args(x, y, player);

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut permettant de récupérer le winner à la fin des coups                            */
    /* --------------------------------------------------------------------------------------   */

    pointcut captureFinCoups(Player winner) :
            call(void gameOver(Player)) &&
                    args(winner);

    before(int x, int y, Player player) : captureParametres(x, y, player) {
        try {
            // enregistrement du coup dans le fichier journalisation.txt qui se trouvera a la racine du projet
            FileWriter fileWriter = new FileWriter("journalisation.txt",true);
            fileWriter.write("nom=" + player.getName() + ",x=" + x + ",y=" + y + "\n");
            fileWriter.flush();
            fileWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    after(Player winner) : captureFinCoups(winner) {
        try {
            // enregistrement du coup dans le fichier journalisation.txt qui se trouvera a la racine du projet
            FileWriter fileWriter = new FileWriter("journalisation.txt",true);
            fileWriter.write("winner=" + winner.getName() + "\n");
            fileWriter.flush();
            fileWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}
