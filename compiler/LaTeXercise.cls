%%
%%  Class-File fuer Uebungzettel der Universitaet Paderborn
%%
%%  Das Papier wird voll ausgenutzt (besser als z.B. bei a4wide).
%%
%%  Der german-Style wird immer zugeladen, ebenso isolatin1, um
%%  Umlaute auf deutschen Tastaturen benutzen zu koennen.
%%
%%  Funktioniert fuer 10pt-, 11pt-, und 12pt-Texte.
%%
%%  --------------------------------------------------------
%%
%%  Folgende Kommandos werden definiert
%%
%%  \dozent{<Dozentenname>}
%%  \vorlesung{<Name der Veranstaltung>}
%%  \semester{<Semestername>}
%%  \tutoren{<Namen der Tutoren>}
%%
%%  Befindet sich im Directory die Datei VORLESUNG.def, so wird
%%  diese eingelesen. D.h., man kann die obigen Kommandos in EINER
%%  Datei abspeichern. Sie werden dann bei jedem (!) Uebungszettel
%%  eingelesen.
%%
%%  \tutoren{...} muss nicht unbedingt benutzt werden. Werden die
%%  uebrigen nicht benutzt, d.h. weder in der Datei, die den Text
%%  des Uebungszettels enthaelt, noch in VORLESUNG.def, so werden
%%  die Informationen ueber die Tastatur abgefragt.
%%
%%  \startnummer{<zahl>} 
%%           Aufgabennummer der ersten Aufgabe des Zettels.
%%           Wird das Kommando nicht benutzt, faengt die Numerierung
%%           eines jeden Blattes bei 1 an.
%%
%%  \kopf[<Abgabedatum>]{<Ausgabedatum>}{<Blattnummer>}
%%           Erzeugt den typischen Uebungszettelkopf. Wird der
%%           optionale Parameter <Abgabedatum> benutzt, wird dieses
%%           ausgegeben.
%%
%%  \begin{aufg}[<Punktzahl>]
%%  <Aufgabentext>
%%  \end{aufg}
%%           Erzeugt etwas Zwischenraum und dann den Text
%%           `AUFGABE x:'. Wird der optionale Parameter <Punktzahl>
%%           benutzt, gibt es den Text `AUFGABE x (<Punktzahl> Punkte):'.
%%
%%  --------------------------------------------------------
%%
%%  Ein moeglicher Inhalt von VORLESUNG.def:
%%
%%  \dozent{Fritz Meyer}
%%  \vorlesung{Parallele Sequentialit"at}
%%  \semester{WS 1999/2000}
%%  \tutoren{Klaus Schmidt, Liese M"uller \\
%%           Willi Koch}
%%
%%  --------------------------------------------------------
%%
%%  Ein moegliches Uebungsblatt:
%%
%%  \documentclass[12pt]{uebung}
%%
%%  \begin{document}
%%
%%  \startnummer{4}
%%
%%  \kopf[5. April 2000]{19. April 2000}{2}
%%
%%  \begin{aufg}
%%  Sei ...
%%  \end{aufg}
%%
%%  \begin{aufg}[3]
%%  M"oge ...
%%  \end{aufg}
%%
%%  \renewcommand{\aufgname}{Exercise}
%%
%%  \selectlanguage{USenglish}
%%
%%  \begin{aufg}
%%  Let ...
%%  \end{aufg}
%%
%%  \end{document}
%%
%%  --------------------------------------------------------
%%
%%  Autor: Rolf Wanka (wanka@uni-paderborn.de)
%%
%%  --------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{LaTeXercise}
              [2000/04/05 v1.5
               Class-File fuer Uebungen]

\DeclareOption{10pt}
    {\PassOptionsToClass{\CurrentOption}{article} %
     \setlength{\hoffset}{-2.3cm} \setlength{\voffset}{-2.5 true cm}}

\DeclareOption{11pt}
    {\PassOptionsToClass{\CurrentOption}{article} %
     \setlength{\hoffset}{-1.6cm} \setlength{\voffset}{-2.3cm}}

\DeclareOption{12pt}
    {\PassOptionsToClass{\CurrentOption}{article} %
     \setlength{\hoffset}{-1.6cm} \setlength{\voffset}{-2.3cm}}

\ExecuteOptions{10pt}
\ProcessOptions

\LoadClass{article}

\RequirePackage{ifthen}
\RequirePackage{german}
\RequirePackage[latin1]{inputenc}

\pagestyle{empty}

\newcount\aufgnr
\aufgnr=1
\def\startnummer#1{\aufgnr=#1}

\frenchspacing

\setlength{\parindent}{0pt}
\setlength{\textwidth}{16.6cm}
\setlength{\textheight}{24cm}
\setlength{\hfuzz}{1mm}

\newcommand{\lecturer}[1]{\def\DOZENT{#1}}
\newcommand{\lecture}[1]{\def\VORLESUNG{#1}}
\newcommand{\term}[1]{\def\SEMESTER{#1}}
\newcommand{\institution}[1]{\def\INSTITUTION{#1}}
\newcommand{\issue}[1]{\def\ISSUE{#1}}
\newcommand{\release}[1]{\def\RELEASE{#1}}
\newcommand{\submission}[1]{\def\SUBMISSION{#1}}

\newcommand{\kopf}{%

\DOZENT \ifthenelse{\isundefined {\RELEASE}}{}{\hfill Release date: \RELEASE}\par
\INSTITUTION \ifthenelse{\isundefined {\SUBMISSION}}{}{\hfill Submission date: \SUBMISSION}\par

\begin{center}\large
    \textbf{\VORLESUNG}      \\[\smallskipamount]
    \SEMESTER               \\[\smallskipamount]
    Assignment \ifthenelse{\isundefined {\ISSUE}}{}{\ISSUE} \\[\smallskipamount]

\end{center}}

\newcommand{\aufgname}{EXERCISE}

\newcommand{\taskdesc}[1][0]{\bigskip\par
\textbf{\aufgname{} \number\aufgnr}%
\ifthenelse{#1 = 0}%
  {}%
  {\ifthenelse{#1 = 1}%
         { (1 Punkt)}%
         { (#1 Punkte)}}\textbf{:}
\global\advance\aufgnr by 1\par}

\newenvironment{task}[1][0]{\taskdesc[#1]}{}


\endinput
%% 
%% End of file `uebung.cls'.
