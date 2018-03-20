package aspects;

import gomoku.core.model.Grid;
import  gomoku.core.Player;

public aspect journalisation {

//    pointcut construct(): within(App) && execution( void test());
//
//    after(): construct() {
//        System.out.println("Aspectz!!!");
//    }

    pointcut placeStone(): within(Grid) && execution( void placeStone(..));

    after() returning() : placeStone() {
        System.out.println("Aspect called after method return !!");
    }
}
