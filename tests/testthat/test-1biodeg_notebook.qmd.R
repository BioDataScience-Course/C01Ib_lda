# Vérifications de biodeg_notebook.qmd
biodeg <- parse_rmd("../../biodeg_notebook.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("biodeg_notebook.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("biodeg_notebook.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction et but", "Matériel et méthodes",
    "Analyses","Description des données", "Set d'apprentissage et de test",
    "Apprentissage du modèle", "Test du modèle", "Conclusion", "Bibliographie")
    %in% (rmd_node_sections(biodeg) |> unlist() |> unique())))
  # Les sections (titres) attendues du document ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "import", "skim", "skimcomment", "split",
    "model", "modelcomment", "confusion", "confusioncomment")
    %in% rmd_node_label(biodeg)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(biodeg))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(biodeg[[1]]$author != "___")
  expect_true(!grepl("__", biodeg[[1]]$author))
  expect_true(grepl("^[^_]....+", urchi[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", biodeg[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", biodeg[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunk 'import' : importation des données", {
  expect_true(is_identical_to_ref("import", "names"))
  # Les colonnes dans le tableau `biodeg` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct.
  # Vérifiez le chunk 'import' du document par rapport à la version d'origine
  # dans le dépôt "template" du document (lien au début du fichier README.md).
})

test_that("Chunk 'skim' & 'skimcomment' : description des données", {
  expect_true(is_identical_to_ref("skimcomment"))
  # La description des données est (partiellement) fausse.
  # Vous devez cochez les phrases qui décrivent les données d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'split' : définition du set d'apprentissage et du set de test", {
  #expect_true(is_identical_to_ref("split"))
  # L'objet 'biodeg_init' n'est pas trouvé ou n'est pas celui attendu.
  # Avez-vous bien respecté la division de 8/10 pour séparer vos deux sets ?
})

test_that("Chunks 'model' & 'modelcomment' : création du classifieur", {
  #expect_true(is_identical_to_ref("model"))
  # L'objet 'bio_lda' n'est pas trouvé ou n'est pas celui attendu
  # Avez-vous bien entraîné votre classifieur avec les données d'apprentissage ?

  expect_true(is_identical_to_ref("modelcomment"))
  # La description du modèle est (partiellement) fausse.
  # Vous devez cochez les phrases qui décrivent le classifieur d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'confusion' & 'confusioncomment' : matrice de confusion et métriques de performances", {
  #expect_true(is_identical_to_ref("confusion"))
  # La matrice de confusion n'est pas trouvée ou n'est pas celle attendue.
  # Vérifiez que la matrice de confusion est effectivement calculée avec les
  # données de test.

  expect_true(is_identical_to_ref("confusioncomment"))
  # L'interprétation de la matrice de confusion et des métriques de performance
  # est (partiellement) fausse.
  # Vous devez cochez les phrases qui décrivent le graphique et les métriques de
  # performances d'un 'x' entre les crochets [] -> [x]. Ensuite, vous devez
  # recompiler la version HTML du bloc-notes (bouton 'Rendu') sans erreur pour
  # réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("La conclusion est-elle complétée ?", {
  expect_true(!(rmd_select(biodeg, by_section(
    "Conclusion")) |> as_document() |> grepl(
      "^- +\\.+ *$", x = _) |> any()))
  # La conclusion relative à la validité du classifieur que vous avez créée ne
  # semble pas présente.
  # Vous devez remplacer les trois points (...) pas vos éléments en faveur ou
  # contre ce classifieur, selon que vous considérez qu'il est valide ou non.
})
