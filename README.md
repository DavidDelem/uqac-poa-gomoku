# uqac-poa-gomoku

<h2>8INF957 Programmation objet avancée - Hivers 2018 - UQAC</h2>
<h3>Devoir 3</h3>
<p><b>David Delemotte, Rénald Morice</b></p>

---

Afin de réaliser ce travail, nous avons utilisé AspectJ. Il faut compiler le projet avec ajc (compilateur d'AspectJ) et non avec javac.
Tutoriel pour configurer IntelliJ: https://www.jetbrains.com/help/idea/aspectj.html

---

<h4>Ce qui a été réalisé</h4>

- [x] Le code fourni n'a pas été modifié<br><br>
- [x] **`aspects/Journalisation.aj`** Enregistre dans un fichier (journalisation.txt) les coups joué ainsi que le résultat final<br><br>
- [x] **`aspects/AdversaireJ.aj`** Implémente le multijoueur. Pour cela, deux joueur + une variable joueurCourant sont crées dans l'aspect. On change à chaque tour le joueur retourné par <i>getCurrentPlayer</i><br><br>
- [x] **`aspects/FinJeu.aj`** Détecte la fin du jeu et affiche le gagnant grâce au pointcut <i>captureGameOver</i>. Empéche de jouer une fois la partie terminée grâce au pointcut <i>captureMakeMove</i>.<br><br>
- [x] **`aspects/ColorisationSuiteGagnante.aj`** Colore la suite gagnante en vert. Pour cela, on a besoin de faire de la réflexivité afin d'accéder à des attributs/méthodes privées:

Le premier pointcut permet de récupérer les WinningStones<br><br>
Le second change la couleur des piéces gagnantes au moment de les dessiner ( en utilisant la réflexBorad.drawStone).
Le dernier appelle la méthode de refresh de l'interface (Borad.drawStones) au moment de l'appel à Board.gameOver car sinon, l'interface n'est pas rafraichie. Borad.drawStones est privée, il faut donc faire de la réflexion pour l'appeler.

---

<h4>Images du résultat</h4>

<p align="center">
  <img src="_imgreadme/resultat.gif"/>
</p>
<br><br>
<p align="center">
  <img src="_imgreadme/journalisation.PNG"/>
</p>