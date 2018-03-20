package aspects;

import gomoku.core.model.Grid;
import  gomoku.core.Player;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

// Aspect permettant de journaliser les coups joués dans un fichier
// Un coup par ligne (joueur et position)
// Fin les coups pour chaque joueur.

public aspect Journalisation {

//    pointcut placeStone(): within(Grid) && execution( void placeStone(..));
//
//    after() returning() : placeStone() {
//        System.out.println("Aspect called after method return !!");
//    }

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut permettant de récupérer les positions et le nom du joueur lors de chaque coup   */
    /* Nom de la classe: Grid                                                                   */
    /* Nom de la méthode: placeStone                                                            */
    /* Type de retour: void                                                                     */
    /* Paramétres: int, int, Player                                                             */
    /* --------------------------------------------------------------------------------------   */

    pointcut captureParametres(int x, int y, Player player) :
            call(void Grid.placeStone(int, int, Player)) &&
            args(x, y, player);

    before(int x, int y, Player player) : captureParametres(x, y, player) {
        System.out.println("Position x: " + x);
        System.out.println("Position y: " + y);
        System.out.println("Nom du joueur: " + player.getName());

        try {
            FileWriter fileWriter = new FileWriter("journalisation.txt",true);
            fileWriter.write("nom=" + player.getName() + ",x=" + x + ",y=" + y + "\n");
            fileWriter.flush();
            fileWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
