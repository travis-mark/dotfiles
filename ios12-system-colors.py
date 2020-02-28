#!/usr/bin/env python

template = """
    /// %(color)s for iOS 12 and lower
    static var %(pdColor)s: UIColor {
        if #available(iOS 13.0, *) {
            return UIColor.%(color)s
        } else {
            if UITraitCollection.shared.isDarkMode {
                return UIColor(red: %(dr)s / 255.0, green: %(dg)s / 255.0, blue: %(db)s / 255.0, alpha: %(da)s)
            } else {
                return UIColor(red: %(lr)s / 255.0, green: %(lg)s / 255.0, blue: %(lb)s / 255.0, alpha: %(la)s)
            }
        }
    }"""

colors = [
    {"color":"label","lr":0,"lg":0,"lb":0,"la":1,"dr":255,"dg":255,"db":255,"da":1},
    {"color":"secondaryLabel","lr":60,"lg":60,"lb":67,"la":0.6,"dr":235,"dg":235,"db":245,"da":0.6},
    {"color":"tertiaryLabel","lr":60,"lg":60,"lb":67,"la":0.3,"dr":235,"dg":235,"db":245,"da":0.3},
    {"color":"quaternaryLabel","lr":60,"lg":60,"lb":60,"la":0.18,"dr":235,"dg":235,"db":245,"da":0.18},
    {"color":"systemFill","lr":120,"lg":120,"lb":128,"la":0.2,"dr":120,"dg":120,"db":128,"da":0.36},
    {"color":"secondarySystemFill","lr":120,"lg":120,"lb":128,"la":0.16,"dr":120,"dg":120,"db":128,"da":0.32},
    {"color":"tertiarySystemFill","lr":118,"lg":118,"lb":128,"la":0.12,"dr":118,"dg":118,"db":128,"da":0.24},
    {"color":"quaternarySystemFill","lr":116,"lg":116,"lb":128,"la":0.08,"dr":116,"dg":116,"db":128,"da":0.18},
    {"color":"placeholderText","lr":60,"lg":60,"lb":67,"la":0.3,"dr":235,"dg":235,"db":245,"da":0.3},
    {"color":"systemBackground","lr":255,"lg":255,"lb":255,"la":1,"dr":0,"dg":0,"db":0,"da":1},
    {"color":"secondarySystemBackground","lr":242,"lg":242,"lb":247,"la":1,"dr":28,"dg":28,"db":30,"da":1},
    {"color":"tertiarySystemBackground","lr":255,"lg":255,"lb":255,"la":1,"dr":44,"dg":44,"db":46,"da":1},
    {"color":"systemGroupedBackground","lr":242,"lg":242,"lb":247,"la":1,"dr":0,"dg":0,"db":0,"da":1},
    {"color":"secondarySystemGroupedBackground","lr":255,"lg":255,"lb":255,"la":1,"dr":28,"dg":28,"db":30,"da":1},
    {"color":"tertiarySystemGroupedBackground","lr":242,"lg":242,"lb":247,"la":1,"dr":44,"dg":44,"db":46,"da":1},
    {"color":"separator","lr":60,"lg":60,"lb":67,"la":0.29,"dr":84,"dg":88,"db":88,"da":0.6},
    {"color":"opaqueSeparator","lr":198,"lg":198,"lb":200,"la":1,"dr":56,"dg":56,"db":58,"da":1},
    {"color":"link","lr":0,"lg":122,"lb":255,"la":1,"dr":9,"dg":132,"db":255,"da":1},
    {"color":"systemBlue","lr":0,"lg":122,"lb":255,"la":1,"dr":10,"dg":132,"db":255,"da":1},
    {"color":"systemGreen","lr":52,"lg":199,"lb":89,"la":1,"dr":48,"dg":209,"db":88,"da":1},
    {"color":"systemIndigo","lr":88,"lg":86,"lb":214,"la":1,"dr":94,"dg":92,"db":230,"da":1},
    {"color":"systemOrange","lr":255,"lg":149,"lb":0,"la":1,"dr":255,"dg":159,"db":10,"da":1},
    {"color":"systemPink","lr":255,"lg":45,"lb":85,"la":1,"dr":255,"dg":55,"db":95,"da":1},
    {"color":"systemPurple","lr":175,"lg":82,"lb":222,"la":1,"dr":191,"dg":90,"db":242,"da":1},
    {"color":"systemRed","lr":255,"lg":59,"lb":48,"la":1,"dr":255,"dg":69,"db":58,"da":1},
    {"color":"systemTeal","lr":90,"lg":200,"lb":250,"la":1,"dr":100,"dg":210,"db":255,"da":1},
    {"color":"systemYellow","lr":255,"lg":204,"lb":0,"la":1,"dr":255,"dg":214,"db":10,"da":1},
    {"color":"systemGray","lr":142,"lg":142,"lb":147,"la":1,"dr":142,"dg":142,"db":147,"da":1},
    {"color":"systemGray2","lr":174,"lg":174,"lb":178,"la":1,"dr":99,"dg":99,"db":102,"da":1},
    {"color":"systemGray3","lr":199,"lg":199,"lb":204,"la":1,"dr":72,"dg":72,"db":74,"da":1},
    {"color":"systemGray4","lr":209,"lg":209,"lb":214,"la":1,"dr":58,"dg":58,"db":60,"da":1},
    {"color":"systemGray5","lr":229,"lg":229,"lb":234,"la":1,"dr":44,"dg":44,"db":46,"da":1},
    {"color":"systemGray6","lr":242,"lg":242,"lb":247,"la":1,"dr":28,"dg":28,"db":30,"da":1}
]

def capFirst(s):
    return ''.join(w[0].upper() + w[1:] for w in s.split())

for color in colors:
    color["pdColor"] = "pd" + capFirst(color["color"].replace("System", "").replace("system", ""))
    print(template % color)