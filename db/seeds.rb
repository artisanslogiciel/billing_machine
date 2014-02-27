#encoding: utf-8
puts 'Seeding database'
Activity.create(label: 'Production')
Activity.create(label: 'Vente')
Activity.create(label: 'Formation')

PaymentTerm.create(label: '30 jours fin de mois')
PaymentTerm.create(label: 'A réception de facture')

# VINSON FRÈRES
# RN7 - NORD
# 26250 LIVRON SUR DROME

# AZUR PLONGÉE
# Port de la Madrague
# 83270 SAINT CYR SUR MER

# CREPS LANGUEDOC-ROUSSILLON
# Établissement de Montpellier
# 2 avenue Charles FLAHAULT
# 34090 MONTPELLIER