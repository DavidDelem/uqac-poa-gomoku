package aspects;

import gomoku.core.model.Spot;
import gomoku.core.model.Grid;
import gomoku.core.Player;
import gomoku.ui.Borad;
import javafx.scene.canvas.GraphicsContext;
import javafx.scene.paint.Color;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

/* --------------------------------------------------------------------------------------   */
/* David Delemotte - Rénald Morice                                                          */
/* Aspect permettant de coloriser en vert la suite gagnante                                 */
/* --------------------------------------------------------------------------------------   */

public aspect ColorisationSuiteGagnante {

    private List<Spot> winningStones;

    // "Faux" player qui sert juste à coloriser les stones gagnantes en vert en l'associant aux stones gagnantes
    private Player playerPourWinningStones = new Player("Nobody", Color.GREEN);

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut permettant de récupérer les winningStones lorsqu'elles sont modifiées           */
    /* --------------------------------------------------------------------------------------   */

    pointcut captureWinningStones(List<Spot> list) : set(List<Spot> Grid.winningStones) && args(list);

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut détectant le dessin des stones                                                  */
    /* --------------------------------------------------------------------------------------   */

    pointcut modifierSpotGagnants(GraphicsContext gc, Spot p) :
            call(void drawStone(GraphicsContext, Spot)) &&
                    args(gc, p);

    /* --------------------------------------------------------------------------------------   */
    /* Pointcut capturant le game over pour faire un refresh final de l'interface               */
    /* --------------------------------------------------------------------------------------   */

    pointcut refreshInterface(Borad myObject) :
            call(void gameOver(Player)) &&
                    target(myObject);

    /* --------------------------------------------------------------------------------------   */
    /* Fonction liée au pointcut captureWinningStones                                           */
    /* --------------------------------------------------------------------------------------   */

    after(List<Spot> list) : captureWinningStones(list) {
        this.winningStones = list;
    }

    /* --------------------------------------------------------------------------------------   */
    /* Fonction liée au pointcut modifierSpotGagnants pour colorer la suite gagnante en vert    */
    /* --------------------------------------------------------------------------------------   */

    before(GraphicsContext gc, Spot p) :  modifierSpotGagnants(gc, p) {

        if(winningStones != null) {
            for (Spot winningStone : winningStones) {
                if(winningStone.x == p.x && winningStone.y == p.y) {
                    try {
                        // On rend publique la méthode setOccupant par reflexion ce qui va nous permettre de l'appeler depuis l'aspect
                        // Ainsi, on va pouvoir changer l'occupant des piéces gagnantes par un player "bidon" de couleur verte
                        Method setOccupant = Spot.class.getDeclaredMethod("setOccupant", Player.class);
                        setOccupant.setAccessible(true);
                        setOccupant.invoke(p, playerPourWinningStones);
                    } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    /* ------------------------------------------------------------------------------------------------------   */
    /* Fonction liée au pointcut refreshInterface pour rafraichir l'interface une dernière fois après la fin    */
    /* ------------------------------------------------------------------------------------------------------   */

    after(Borad myObject) : refreshInterface(myObject) {
        try {
            // On rend public drawStones par reflexion puis on l'invoque pour redessiner toute l'interface
            // Les piéces gagnantes apparaitrons ainsi vert grâces aux manipulation faites dans le "before" précédent
            Method drawStones = Borad.class.getDeclaredMethod("drawStones");
            drawStones.setAccessible(true);
            drawStones.invoke(myObject);
        } catch (NoSuchMethodException | IllegalAccessException | InvocationTargetException e) {
            e.printStackTrace();
        }

    }
}
