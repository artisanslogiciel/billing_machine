#encoding: utf-8
puts 'Seeding database'
Activity.create(label: 'Production')
Activity.create(label: 'Vente')
Activity.create(label: 'Formation')

PaymentTerm.create(label: '30 jours fin de mois')
PaymentTerm.create(label: 'A réception de facture')

