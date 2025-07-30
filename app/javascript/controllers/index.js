// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
eagerLoadControllersFrom("controllers", application)
import ScrollFadeController from "./scroll_fade_controller" // Importez votre contrôleur
application.register("scroll-fade", ScrollFadeController) // Enregistrez-le
