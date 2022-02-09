# FSM (Finite State Machine) Domain Specific Metamodel, Language and Compiler to Java
by Léo Rolland and Valentin Lorand

## Context

Based on lectures of Pr. Benoit Combemale ([view academic personal page](https://people.irisa.fr/Benoit.Combemale)) and labs with Gwendal Jouneaux.

[View tutorial on Github](https://github.com/selabs-ur1/dsl)

> Plutot que d’utiliser une librairie d'exécution d'un FSM dans un langage généraliste, on va proposer directement un langage spécifique. Exprimer la solution à notre problème dans les termes de l’espace de notre problème permet notamment de minimiser la complexité accidentelle liée au choix de langage/outils, de communiquer, de réfléchir, dans les termes du problème.

> Dans l'ingénierie des modèles : un modèle est une abstraction de la réalité : pas la seule possible. Chacune des préoccupation est adressée par un modèle particulier. Quitte à les séparer, autant utiliser des outils adéquats pour chaque préoccupation, avec des langages spécifiques, des outils et méthodes. 

> Le méta méta modèle ECore permet de créer un métamodèle permetant de modéliser tous les FSM possibles

- **Ecore** : méta méta modèle
- **FSM system** (modelisé avec Ecore) : méta modèle (une instance du méta méta modèle)
- **Un FSM en particulier** (décrit par une syntaxe concrete) : Modèle, (une instance du méta modèle)

> XText permet de définir une grammaire qui sera interpretée en AST (Abstract Syntax Tree) d'éléments Ecore par un lexer, puis un parseur (Fournis par Xtext).

> Notre compilateur (backend) parcours l'AST selon le design pattern Visiteur et génère un code Java exécutable qui permet d'exécuter notre FSM de manière intéractive.


## Getting started

### Requirements
- Java 11
- Eclipse Gemoc Studio ([website](https://gemoc.org/studio)) 

### Build the project and run the eclipse DSL App
1. Clone the repository (workspace)
2. Open Gemoc Studio and open the workspace
3. Open `fsm.genmodel` (in `fr.leorolland.fsm.model`) 
4. Right click on `FSM` > Generate all
5. Right click on `GenerateFsmDsl.mwe2` (in `org.xtext.example.fsmdsl` > src > mysql) > Run as > MWE2 Workflow
6. Right click on `org.xtext.example.fsmdsl.ide` > Run as > Eclipse Application
7. Create a project 
8. Create a `example.fsm` with the following content
9. Save
10. View and execute in `src-codegen`