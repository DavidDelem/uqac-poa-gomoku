# uqac-poa-gomoku

<h2>8INF957 Programmation objet avancée - Hivers 2018 - UQAC</h2>
<h3>Devoir 3</h3>
<p><b>David Delemotte, Rénald Morice</b></p>

---

Afin de réaliser ce travail, nous avons utilisé AspectJ. Il faut compiler le projet avec ajc, compilateur d'AspectJ et non avec javac pour que les aspects fonctionnent.

---

<h4>Ce qui a été réalisé</h4>

- [x] Le code fourni n'a pas été modifié<br><br>
- [x] **`aspects/Journalisation.aj`** Enregistre dans un fichier les coups joué en interceptant les paramètres transmits à la méthode <i>placeStone</i>. Le fichier créé se nome journalisation.txt.<br><br>
- [x] **`aspects/AdversaireJ.aj`** Implémente le multijoueur. Pour cela, deux joueur + une variable enregistrant le joueur courant sont crées dans l'aspect. On peut alors modifier à chaque tour le joueur retourné par <i>getCurrentPlayer</i><br><br>
- [x] **`aspects/FinJeu.aj`** Détecte la fin du jeu et affiche le gagnant grâce au pointcut <i>captureGameOver</i>. Empéche de jouer une fois la partie terminée grâce au pointcut <i>captureMakeMove</i> (pour cela on bloque l'éxecution de la méthode <i>MakeMove</i>). Colore la suite gagnante.<br><br>

---

<h4>Gifs du résultat</h4>

gif multijoueur
gif partie finie + résultats

---

Tutoriels a suivre pour faire marcher AspectJ avec IntelliJ (AspectJ est compatible avec IntelliJ Ultimate uniquement):

https://www.jetbrains.com/help/idea/creating-aspects.html <br>
https://www.jetbrains.com/help/idea/aspectj.html <br><br>
Et changer le compiler d'inteliJ pour ajc (au lieu de javac) pour que les aspects soient pris en compte (file->settings->java compiler), avec comme "Path to ajc compiler": aspectj1.8\lib\aspectjtools.jar
<br><br>
Tutos AspectJ:<br>
http://tzachsolomon.blogspot.ca/2015/08/how-to-create-hello-world-with-intellij.html
https://www.safaribooksonline.com/library/view/aspectj-cookbook/0596006543/ch04s03.html

Doc officielle: <br>
http://www.eclipse.org/aspectj/doc/next/progguide/starting-aspectj.html

---
