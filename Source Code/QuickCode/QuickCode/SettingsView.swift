//
//  SettingsView.swift
//  QuickCode
//
//  Created by Mark Howard on 01/04/2024.
//

import SwiftUI
import CodeMirror_SwiftUI

struct SettingsView: View {
    //Track Tab Selection
    @State private var tabSelection = 1
    //Trigger Open URL Link
    @Environment(\.openURL) var openURL
    //Store Selected Syntax Highlighting And Editor Theme In User Defaults
    @AppStorage("selectedSyntax") var selectedSyntax = 51
    @AppStorage("selectedTheme") var selectedTheme = 80
    @AppStorage("syntax") var syntax: CodeMode = CodeMode.text
    @AppStorage("theme") var theme: CodeViewTheme = CodeViewTheme.zenburnesque
    //Store Editor Settings In User Defaults
    @AppStorage("lineWrapping") var lineWrapping = true
    @AppStorage("showInvisibleCharacters") var showInvisibleCharacters = false
    @AppStorage("fontSize") var fontSize = 12
    var body: some View {
        //Set Tab View Between Settings Pages
        TabView(selection: $tabSelection) {
            editorAndThemeSettings
                .tabItem {
                    Image(systemName: "pencil")
                    Text("Editor")
                }
                .tag(1)
            misc
                .tabItem {
                    Image(systemName: "ellipsis.circle")
                    Text("Misc")
                }
                .tag(2)
        }
    }
    //Editor Settings Page
    var editorAndThemeSettings: some View {
        Form {
            //Change Font Size, Toggle Line Wrapping And Toggle Invisible Characters
            VStack {
                Stepper("Font Size - \(fontSize)", value: $fontSize, in: 1...120)
                Toggle(isOn: $lineWrapping) {
                    Text("Line Wrapping")
                }
                .toggleStyle(.switch)
                Toggle(isOn: $showInvisibleCharacters) {
                    Text("Show Invisible Characters")
                }
                .toggleStyle(.switch)
                //Theme Picker
                Picker(selection: $selectedTheme, label: Text("Theme")) {
                    Group {
                        Group {
                            Button("BB Edit") {}
                                .tag(1)
                            Button("All Hallow Eve") {}
                                .tag(2)
                            Button("Idle Fingers") {}
                                .tag(3)
                            Button("Space Cadet") {}
                                .tag(4)
                            Button("Idle") {}
                                .tag(5)
                            Button("Oceanic") {}
                                .tag(6)
                            Button("Clouds") {}
                                .tag(7)
                            Button("GitHub") {}
                                .tag(8)
                            Button("Ryan Light") {}
                                .tag(9)
                            Button("Black Pearl") {}
                                .tag(10)
                        }
                        Group {
                            Button("Mono Industrial") {}
                                .tag(11)
                            Button("Happy Happy Joy Joy 2") {}
                                .tag(12)
                            Button("Cube 2 Media") {}
                                .tag(13)
                            Button("Friendship Bracelet") {}
                                .tag(14)
                            Button("Classic Modififed") {}
                                .tag(15)
                            Button("Amy") {}
                                .tag(16)
                            Button("Demo") {}
                                .tag(17)
                            Button("R Dark") {}
                                .tag(18)
                            Button("Espresso") {}
                                .tag(19)
                            Button("Sunburst") {}
                                .tag(20)
                        }
                        Group {
                            Button("Made Of Code") {}
                                .tag(21)
                            Button("Arona") {}
                                .tag(22)
                            Button("Putty") {}
                                .tag(23)
                            Button("Night Lion") {}
                                .tag(24)
                            Button("Sidewalk Chalk") {}
                                .tag(25)
                            Button("Swyphs II") {}
                                .tag(26)
                            Button("I Plastic") {}
                                .tag(27)
                            Button("Solarized (Light)") {}
                                .tag(28)
                            Button("Mac Classic") {}
                                .tag(29)
                            Button("Pastels On Dark") {}
                                .tag(30)
                        }
                        Group {
                            Button("IR Black") {}
                                .tag(31)
                            Button("Material") {}
                                .tag(32)
                            Button("Monokai Fannon Edition") {}
                                .tag(33)
                            Button("Monokai Bright") {}
                                .tag(34)
                            Button("Eiffel") {}
                                .tag(35)
                            Button("Base 16 Light") {}
                                .tag(36)
                            Button("Oceanic Muted") {}
                                .tag(37)
                            Button("Summer Fruit") {}
                                .tag(38)
                            Button("Espresso Libre") {}
                                .tag(39)
                            Button("KR Theme") {}
                                .tag(40)
                        }
                        Group {
                            Button("Mreq") {}
                                .tag(41)
                            Button("Chanfle") {}
                                .tag(42)
                            Button("Venom") {}
                                .tag(43)
                            Button("Juicy") {}
                                .tag(44)
                            Button("Coda") {}
                                .tag(45)
                            Button("Fluid Vision") {}
                                .tag(46)
                            Button("Tomorrow Night Blue") {}
                                .tag(47)
                            Button("Migucwb (Amiga)") {}
                                .tag(48)
                            Button("Twilight") {}
                                .tag(49)
                            Button("Vibrant Ink") {}
                                .tag(50)
                        }
                        Group {
                            Button("Summer Sun") {}
                                .tag(51)
                            Button("Monokai") {}
                                .tag(52)
                            Button("Rails Envy") {}
                                .tag(53)
                            Button("Merbivore") {}
                                .tag(54)
                            Button("Dracula") {}
                                .tag(55)
                            Button("Pastie") {}
                                .tag(56)
                            Button("Low Light") {}
                                .tag(57)
                            Button("Spectacular") {}
                                .tag(58)
                            Button("Smoothy") {}
                                .tag(59)
                            Button("Vibrant Fin") {}
                                .tag(60)
                        }
                        Group {
                            Button("Blackboard") {}
                                .tag(61)
                            Button("Slush & Poppies") {}
                                .tag(62)
                            Button("Freckle") {}
                                .tag(63)
                            Button("Fantasy Script") {}
                                .tag(64)
                            Button("Tomorrow Night Eighties") {}
                                .tag(65)
                            Button("Rhuk") {}
                                .tag(66)
                            Button("Toy Chest") {}
                                .tag(67)
                            Button("Fake") {}
                                .tag(68)
                            Button("Emacs Strict") {}
                                .tag(69)
                            Button("Merbivore Soft") {}
                                .tag(70)
                        }
                        Group {
                            Button("Fade To Grey") {}
                                .tag(71)
                            Button("Monokai Sublime") {}
                                .tag(72)
                            Button("Johnny") {}
                                .tag(73)
                            Button("Railscasts") {}
                                .tag(74)
                            Button("Argonaut") {}
                                .tag(75)
                            Button("Tomorrow Night Bright") {}
                                .tag(76)
                            Button("Lazy") {}
                                .tag(77)
                            Button("Tomorrow Night") {}
                                .tag(78)
                            Button("Bongzilla") {}
                                .tag(79)
                            Button("Zenburnesque") {}
                                .tag(80)
                        }
                        Group {
                            Button("Notebook") {}
                                .tag(81)
                            Button("Django (Smoothy)") {}
                                .tag(82)
                            Button("Blackboard Black") {}
                                .tag(83)
                            Button("Black Pearl II") {}
                                .tag(84)
                            Button("Kuroir") {}
                                .tag(85)
                            Button("Cobalt") {}
                                .tag(86)
                            Button("Ayu-Mirage") {}
                                .tag(87)
                            Button("Chrome DevTools") {}
                                .tag(88)
                            Button("Prospettiva") {}
                                .tag(89)
                            Button("Espresso Soda") {}
                                .tag(90)
                        }
                        Group {
                            Button("Birds Of Paradise") {}
                                .tag(91)
                            Button("Text Ex Machina") {}
                                .tag(92)
                            Button("Django") {}
                                .tag(93)
                            Button("Tomorrow") {}
                                .tag(94)
                            Button("Solarized (Dark)") {}
                                .tag(95)
                            Button("Plastic Code Wrap") {}
                                .tag(96)
                            Button("Material Palenight") {}
                                .tag(97)
                            Button("Bespin") {}
                                .tag(98)
                            Button("Espresso Tutti") {}
                                .tag(99)
                            Button("Vibrant Tango") {}
                                .tag(100)
                        }
                    }
                    Group {
                        Button("Tubster") {}
                            .tag(101)
                        Button("Dark Pastel") {}
                            .tag(102)
                        Button("Dawn") {}
                            .tag(103)
                        Button("Tango") {}
                            .tag(104)
                        Button("Clouds Midnight") {}
                            .tag(105)
                        Button("Glitterbomb") {}
                            .tag(106)
                        Button("IR White") {}
                            .tag(107)
                    }
                }
                .pickerStyle(.menu)
                //Check For Theme Changes
                .onChange(of: selectedTheme) {
                    if selectedTheme == 1 {
                        theme = CodeViewTheme.bbedit
                    } else if selectedTheme == 2 {
                        theme = CodeViewTheme.allHallowEve
                    } else if selectedTheme == 3 {
                        theme = CodeViewTheme.idleFingers
                    } else if selectedTheme == 4 {
                        theme = CodeViewTheme.spaceCadet
                    } else if selectedTheme == 5 {
                        theme = CodeViewTheme.idle
                    } else if selectedTheme == 6 {
                        theme = CodeViewTheme.oceanic
                    } else if selectedTheme == 7 {
                        theme = CodeViewTheme.clouds
                    } else if selectedTheme == 8 {
                        theme = CodeViewTheme.github
                    } else if selectedTheme == 9 {
                        theme = CodeViewTheme.ryanLight
                    } else if selectedTheme == 10 {
                        theme = CodeViewTheme.blackPearl
                    } else if selectedTheme == 11 {
                        theme = CodeViewTheme.monoIndustrial
                    } else if selectedTheme == 12 {
                        theme = CodeViewTheme.happyHappyJoyJoy2
                    } else if selectedTheme == 13 {
                        theme = CodeViewTheme.cube2Media
                    } else if selectedTheme == 14 {
                        theme = CodeViewTheme.friendshipBracelet
                    } else if selectedTheme == 15 {
                        theme = CodeViewTheme.classicModified
                    } else if selectedTheme == 16 {
                        theme = CodeViewTheme.amy
                    } else if selectedTheme == 17 {
                        theme = CodeViewTheme.default
                    } else if selectedTheme == 18 {
                        theme = CodeViewTheme.rdrak
                    } else if selectedTheme == 19 {
                        theme = CodeViewTheme.espresso
                    } else if selectedTheme == 20 {
                        theme = CodeViewTheme.sunburst
                    } else if selectedTheme == 21 {
                        theme = CodeViewTheme.madeOfCode
                    } else if selectedTheme == 22 {
                        theme = CodeViewTheme.arona
                    } else if selectedTheme == 23 {
                        theme = CodeViewTheme.putty
                    } else if selectedTheme == 24 {
                        theme = CodeViewTheme.nightlion
                    } else if selectedTheme == 25 {
                        theme = CodeViewTheme.sidewalkchalk
                    } else if selectedTheme == 26 {
                        theme = CodeViewTheme.swyphsii
                    } else if selectedTheme == 27 {
                        theme = CodeViewTheme.iplastic
                    } else if selectedTheme == 28 {
                        theme = CodeViewTheme.solarizedLight
                    } else if selectedTheme == 29 {
                        theme = CodeViewTheme.macClassic
                    } else if selectedTheme == 30 {
                        theme = CodeViewTheme.pastelsOnDark
                    } else if selectedTheme == 31 {
                        theme = CodeViewTheme.irBlack
                    } else if selectedTheme == 32 {
                        theme = CodeViewTheme.material
                    } else if selectedTheme == 33 {
                        theme = CodeViewTheme.monokaiFannonedition
                    } else if selectedTheme == 34 {
                        theme = CodeViewTheme.monokaiBright
                    } else if selectedTheme == 35 {
                        theme = CodeViewTheme.eiffel
                    } else if selectedTheme == 36 {
                        theme = CodeViewTheme.base16Light
                    } else if selectedTheme == 37 {
                        theme = CodeViewTheme.oceanicMuted
                    } else if selectedTheme == 38 {
                        theme = CodeViewTheme.summerfruit
                    } else if selectedTheme == 39 {
                        theme = CodeViewTheme.espressoLibre
                    } else if selectedTheme == 40 {
                        theme = CodeViewTheme.krtheme
                    } else if selectedTheme == 41 {
                        theme = CodeViewTheme.mreq
                    } else if selectedTheme == 42 {
                        theme = CodeViewTheme.chanfle
                    } else if selectedTheme == 43 {
                        theme = CodeViewTheme.venom
                    } else if selectedTheme == 44 {
                        theme = CodeViewTheme.juicy
                    } else if selectedTheme == 45 {
                        theme = CodeViewTheme.coda
                    } else if selectedTheme == 46 {
                        theme = CodeViewTheme.fluidvision
                    } else if selectedTheme == 47 {
                        theme = CodeViewTheme.tomorrowNightBlue
                    } else if selectedTheme == 48 {
                        theme = CodeViewTheme.magicwbAmiga
                    } else if selectedTheme == 49 {
                        theme = CodeViewTheme.twilight
                    } else if selectedTheme == 50 {
                        theme = CodeViewTheme.vibrantInk
                    } else if selectedTheme == 51 {
                        theme = CodeViewTheme.summerSun
                    } else if selectedTheme == 52 {
                        theme = CodeViewTheme.monokai
                    } else if selectedTheme == 53 {
                        theme = CodeViewTheme.railsEnvy
                    } else if selectedTheme == 54 {
                        theme = CodeViewTheme.merbivore
                    } else if selectedTheme == 55 {
                        theme = CodeViewTheme.dracula
                    } else if selectedTheme == 56 {
                        theme = CodeViewTheme.pastie
                    } else if selectedTheme == 57 {
                        theme = CodeViewTheme.lowlight
                    } else if selectedTheme == 58 {
                        theme = CodeViewTheme.spectacular
                    } else if selectedTheme == 59 {
                        theme = CodeViewTheme.smoothy
                    } else if selectedTheme == 60 {
                        theme = CodeViewTheme.vibrantFin
                    } else if selectedTheme == 61 {
                        theme = CodeViewTheme.blackboard
                    } else if selectedTheme == 62 {
                        theme = CodeViewTheme.slushPoppies
                    } else if selectedTheme == 63 {
                        theme = CodeViewTheme.freckle
                    } else if selectedTheme == 64 {
                        theme = CodeViewTheme.fantasyscript
                    } else if selectedTheme == 65 {
                        theme = CodeViewTheme.tomorrowNightEighties
                    } else if selectedTheme == 66 {
                        theme = CodeViewTheme.rhuk
                    } else if selectedTheme == 67 {
                        theme = CodeViewTheme.toyChest
                    } else if selectedTheme == 68 {
                        theme = CodeViewTheme.fake
                    } else if selectedTheme == 69 {
                        theme = CodeViewTheme.emacsStrict
                    } else if selectedTheme == 70 {
                        theme = CodeViewTheme.merbivoreSoft
                    } else if selectedTheme == 71 {
                        theme = CodeViewTheme.fadeToGrey
                    } else if selectedTheme == 72 {
                        theme = CodeViewTheme.monokaiSublime
                    } else if selectedTheme == 73 {
                        theme = CodeViewTheme.johnny
                    } else if selectedTheme == 74 {
                        theme = CodeViewTheme.railscasts
                    } else if selectedTheme == 75 {
                        theme = CodeViewTheme.argonaut
                    } else if selectedTheme == 76 {
                        theme = CodeViewTheme.tomorrowNightBright
                    } else if selectedTheme == 77 {
                        theme = CodeViewTheme.lazy
                    } else if selectedTheme == 78 {
                        theme = CodeViewTheme.tomorrowNight
                    } else if selectedTheme == 79 {
                        theme = CodeViewTheme.bongzilla
                    } else if selectedTheme == 80 {
                        theme = CodeViewTheme.zenburnesque
                    } else if selectedTheme == 81 {
                        theme = CodeViewTheme.notebook
                    } else if selectedTheme == 82 {
                        theme = CodeViewTheme.djangoSmoothy
                    } else if selectedTheme == 83 {
                        theme = CodeViewTheme.blackboardBlack
                    } else if selectedTheme == 84 {
                        theme = CodeViewTheme.blackPearlii
                    } else if selectedTheme == 85 {
                        theme = CodeViewTheme.kuroir
                    } else if selectedTheme == 86 {
                        theme = CodeViewTheme.cobalt
                    } else if selectedTheme == 87 {
                        theme = CodeViewTheme.ayuMirage
                    } else if selectedTheme == 88 {
                        theme = CodeViewTheme.chromeDevtools
                    } else if selectedTheme == 89 {
                        theme = CodeViewTheme.prospettiva
                    } else if selectedTheme == 90 {
                        theme = CodeViewTheme.espressoSoda
                    } else if selectedTheme == 91 {
                        theme = CodeViewTheme.birdsOfParadise
                    } else if selectedTheme == 92 {
                        theme = CodeViewTheme.textExMachina
                    } else if selectedTheme == 93 {
                        theme = CodeViewTheme.django
                    } else if selectedTheme == 94 {
                        theme = CodeViewTheme.tomorrow
                    } else if selectedTheme == 95 {
                        theme = CodeViewTheme.solarizedDark
                    } else if selectedTheme == 96 {
                        theme = CodeViewTheme.plasticcodewrap
                    } else if selectedTheme == 97 {
                        theme = CodeViewTheme.materialPalenight
                    } else if selectedTheme == 98 {
                        theme = CodeViewTheme.bespin
                    } else if selectedTheme == 99 {
                        theme = CodeViewTheme.espressoTutti
                    } else if selectedTheme == 100 {
                        theme = CodeViewTheme.vibrantTango
                    } else if selectedTheme == 101 {
                        theme = CodeViewTheme.tubster
                    } else if selectedTheme == 102 {
                        theme = CodeViewTheme.darkpastel
                    } else if selectedTheme == 103 {
                        theme = CodeViewTheme.dawn
                    } else if selectedTheme == 104 {
                        theme = CodeViewTheme.tango
                    } else if selectedTheme == 105 {
                        theme = CodeViewTheme.cloudsMidnight
                    } else if selectedTheme == 106 {
                        theme = CodeViewTheme.glitterbomb
                    } else if selectedTheme == 107 {
                        theme = CodeViewTheme.irWhite
                    }
                }
                //Syntax Picker
                Picker(selection: $selectedSyntax, label: Text("Syntax")) {
                    Group {
                        Button("APL") {}
                            .tag(1)
                        Button("PGP") {}
                            .tag(2)
                        Button("ASN") {}
                            .tag(3)
                        Button("C Make") {}
                            .tag(4)
                        Button("C") {}
                            .tag(5)
                        Button("C++") {}
                            .tag(6)
                        Button("Objective C") {}
                            .tag(7)
                        Button("Kotlin") {}
                            .tag(8)
                        Button("Scala") {}
                            .tag(9)
                        Button("C#") {}
                            .tag(10)
                    }
                    Group {
                        Button("Java") {}
                            .tag(11)
                        Button("Cobol") {}
                            .tag(12)
                        Button("Coffee Script") {}
                            .tag(13)
                        Button("Lisp") {}
                            .tag(14)
                        Button("CSS") {}
                            .tag(15)
                        Button("Django") {}
                            .tag(16)
                        Button("Docker File") {}
                            .tag(17)
                        Button("ERLang") {}
                            .tag(18)
                        Button("Fortran") {}
                            .tag(19)
                        Button("Go") {}
                            .tag(20)
                    }
                    Group {
                        Button("Groovy") {}
                            .tag(21)
                        Button("Haskell") {}
                            .tag(22)
                        Button("HTML") {}
                            .tag(23)
                        Button("HTTP") {}
                            .tag(24)
                        Button("Javascript") {}
                            .tag(25)
                        Button("Typescript") {}
                            .tag(26)
                        Button("JSON") {}
                            .tag(27)
                        Button("Ecma") {}
                            .tag(28)
                        Button("Jinja") {}
                            .tag(29)
                        Button("Lua") {}
                            .tag(30)
                    }
                    Group {
                        Button("Markdown") {}
                            .tag(31)
                        Button("Maths") {}
                            .tag(32)
                        Button("Pascal") {}
                            .tag(33)
                        Button("Perl") {}
                            .tag(34)
                        Button("PHP") {}
                            .tag(35)
                        Button("Powershell") {}
                            .tag(36)
                        Button("Properties") {}
                            .tag(37)
                        Button("Protobuf") {}
                            .tag(38)
                        Button("Python") {}
                            .tag(39)
                        Button("R") {}
                            .tag(40)
                    }
                    Group {
                        Button("Ruby") {}
                            .tag(41)
                        Button("Rust") {}
                            .tag(42)
                        Button("Sass") {}
                            .tag(43)
                        Button("Scheme") {}
                            .tag(44)
                        Button("Shell") {}
                            .tag(45)
                        Button("SQL") {}
                            .tag(46)
                        Button("SQLite") {}
                            .tag(47)
                        Button("MySQL") {}
                            .tag(48)
                        Button("Latex") {}
                            .tag(49)
                        Button("Swift") {}
                            .tag(50)
                    }
                    Group {
                        Button("Text") {}
                            .tag(51)
                        Button("Toml") {}
                            .tag(52)
                        Button("VB") {}
                            .tag(53)
                        Button("Vue") {}
                            .tag(54)
                        Button("XML") {}
                            .tag(55)
                        Button("YAML") {}
                            .tag(56)
                        Button("Dart") {}
                            .tag(57)
                        Button("Ntriples") {}
                            .tag(58)
                        Button("Sparql") {}
                            .tag(59)
                        Button("Turtle") {}
                            .tag(60)
                    }
                }
                .pickerStyle(.menu)
                //Check For Syntax Changes
                .onChange(of: selectedSyntax) {
                    if selectedSyntax == 1 {
                        syntax = CodeMode.apl
                    } else if selectedSyntax == 2 {
                        syntax = CodeMode.pgp
                    } else if selectedSyntax == 3 {
                        syntax = CodeMode.asn
                    } else if selectedSyntax == 4 {
                        syntax = CodeMode.cmake
                    } else if selectedSyntax == 5 {
                        syntax = CodeMode.c
                    } else if selectedSyntax == 6 {
                        syntax = CodeMode.cplus
                    } else if selectedSyntax == 7 {
                        syntax = CodeMode.objc
                    } else if selectedSyntax == 8 {
                        syntax = CodeMode.kotlin
                    } else if selectedSyntax == 9 {
                        syntax = CodeMode.scala
                    } else if selectedSyntax == 10 {
                        syntax = CodeMode.csharp
                    } else if selectedSyntax == 11 {
                        syntax = CodeMode.java
                    } else if selectedSyntax == 12 {
                        syntax = CodeMode.cobol
                    } else if selectedSyntax == 13 {
                        syntax = CodeMode.coffeescript
                    } else if selectedSyntax == 14 {
                        syntax = CodeMode.lisp
                    } else if selectedSyntax == 15 {
                        syntax = CodeMode.css
                    } else if selectedSyntax == 16 {
                        syntax = CodeMode.django
                    } else if selectedSyntax == 17 {
                        syntax = CodeMode.dockerfile
                    } else if selectedSyntax == 18 {
                        syntax = CodeMode.erlang
                    } else if selectedSyntax == 19 {
                        syntax = CodeMode.fortran
                    } else if selectedSyntax == 20 {
                        syntax = CodeMode.go
                    } else if selectedSyntax == 21 {
                        syntax = CodeMode.groovy
                    } else if selectedSyntax == 22 {
                        syntax = CodeMode.haskell
                    } else if selectedSyntax == 23 {
                        syntax = CodeMode.html
                    } else if selectedSyntax == 24 {
                        syntax = CodeMode.http
                    } else if selectedSyntax == 25 {
                        syntax = CodeMode.javascript
                    } else if selectedSyntax == 26 {
                        syntax = CodeMode.typescript
                    } else if selectedSyntax == 27 {
                        syntax = CodeMode.json
                    } else if selectedSyntax == 28 {
                        syntax = CodeMode.ecma
                    } else if selectedSyntax == 29 {
                        syntax = CodeMode.jinja
                    } else if selectedSyntax == 30 {
                        syntax = CodeMode.lua
                    } else if selectedSyntax == 31 {
                        syntax = CodeMode.markdown
                    } else if selectedSyntax == 32 {
                        syntax = CodeMode.maths
                    } else if selectedSyntax == 33 {
                        syntax = CodeMode.pascal
                    } else if selectedSyntax == 34 {
                        syntax = CodeMode.perl
                    } else if selectedSyntax == 35 {
                        syntax = CodeMode.php
                    } else if selectedSyntax == 36 {
                        syntax = CodeMode.powershell
                    } else if selectedSyntax == 37 {
                        syntax = CodeMode.properties
                    } else if selectedSyntax == 38 {
                        syntax = CodeMode.protobuf
                    } else if selectedSyntax == 39 {
                        syntax = CodeMode.python
                    } else if selectedSyntax == 40 {
                        syntax = CodeMode.r
                    } else if selectedSyntax == 41 {
                        syntax = CodeMode.ruby
                    } else if selectedSyntax == 42 {
                        syntax = CodeMode.rust
                    } else if selectedSyntax == 43 {
                        syntax = CodeMode.sass
                    } else if selectedSyntax == 44 {
                        syntax = CodeMode.scheme
                    } else if selectedSyntax == 45 {
                        syntax = CodeMode.shell
                    } else if selectedSyntax == 46 {
                        syntax = CodeMode.sql
                    } else if selectedSyntax == 47 {
                        syntax = CodeMode.sqllite
                    } else if selectedSyntax == 48 {
                        syntax = CodeMode.mysql
                    } else if selectedSyntax == 49 {
                        syntax = CodeMode.latex
                    } else if selectedSyntax == 50 {
                        syntax = CodeMode.swift
                    } else if selectedSyntax == 51 {
                        syntax = CodeMode.text
                    } else if selectedSyntax == 52 {
                        syntax = CodeMode.toml
                    } else if selectedSyntax == 53 {
                        syntax = CodeMode.vb
                    } else if selectedSyntax == 54 {
                        syntax = CodeMode.vue
                    } else if selectedSyntax == 55 {
                        syntax = CodeMode.xml
                    } else if selectedSyntax == 56 {
                        syntax = CodeMode.yaml
                    } else if selectedSyntax == 57 {
                        syntax = CodeMode.dart
                    } else if selectedSyntax == 58 {
                        syntax = CodeMode.ntriples
                    } else if selectedSyntax == 59 {
                        syntax = CodeMode.sparql
                    } else if selectedSyntax == 60 {
                        syntax = CodeMode.turtle
                    }
                }
                //Testing View
                CodeView(theme: theme, code: .constant("Hello World"), mode: syntax.mode(), fontSize: fontSize, showInvisibleCharacters: showInvisibleCharacters, lineWrapping: lineWrapping)
            }
        }
        .padding(.all)
    }
    //Misc Settings Page
    var misc: some View {
        Form {
            //App Info
            GroupBox(label: Label("Info", systemImage: "info.circle")) {
                VStack {
                    HStack {
                        Spacer()
                        Text("Version - \(Text("1.1").bold())")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Text("Build - \(Text("9").bold())")
                        Spacer()
                    }
                }
            }
            //App Feedback Button
            GroupBox(label: Label("More", systemImage: "ellipsis.circle")) {
                HStack {
                    Spacer()
                    Button(action: {SendEmail.send()}) {
                        Text("Send Feedback...")
                    }
                    Spacer()
                    Button(action: {openURL(URL(string: "https://github.com/markydoodled/QuickCode")!)}) {
                        Text("GitHub Repository...")
                    }
                    Spacer()
                    Button(action: {openURL(URL(string: "https://markydoodled.com/")!)}) {
                        Text("Portfolio...")
                    }
                    Spacer()
                }
            }
        }
        .padding(.all)
    }
}

//Set Default Information For Sending Feedback Email
class SendEmail: NSObject {
    static func send() {
        let service = NSSharingService(named: NSSharingService.Name.composeEmail)!
        service.recipients = ["markhoward@markydoodled.com"]
        service.subject = "QuickCode Feedback"
        service.perform(withItems: ["Please Fill Out All Relevant Sections:", "Report A Bug - ", "Rate The App - ", "Suggest An Improvement - "])
    }
}

#Preview {
    SettingsView()
}
