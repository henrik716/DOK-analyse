"""
Model exported as python.
Name : DOK-analyse (Område)
Group : 
With QGIS : 32000
"""

from qgis.core import QgsProcessing
from qgis.core import QgsProcessingAlgorithm
from qgis.core import QgsProcessingMultiStepFeedback
from qgis.core import QgsProcessingParameterVectorLayer
from qgis.core import QgsProcessingParameterFeatureSink
import processing


class DokanalyseOmrde(QgsProcessingAlgorithm):

    def initAlgorithm(self, config=None):
        self.addParameter(QgsProcessingParameterVectorLayer('DOKdatastrm', 'DOK data', types=[QgsProcessing.TypeVectorPolygon], defaultValue=None))
        self.addParameter(QgsProcessingParameterVectorLayer('Interesseomrde', 'Interesseområde', types=[QgsProcessing.TypeVectorPolygon], defaultValue=None))
        self.addParameter(QgsProcessingParameterFeatureSink('Omrdeanalyse', 'Områdeanalyse', optional=True, type=QgsProcessing.TypeVectorAnyGeometry, createByDefault=True, defaultValue=None))

    def processAlgorithm(self, parameters, context, model_feedback):
        # Use a multi-step feedback, so that individual child algorithm progress reports are adjusted for the
        # overall progress through the model
        feedback = QgsProcessingMultiStepFeedback(7, model_feedback)
        results = {}
        outputs = {}

        # Feltkalkulator - Navn
        alg_params = {
            'FIELD_LENGTH': 50,
            'FIELD_NAME': 'type',
            'FIELD_PRECISION': 0,
            'FIELD_TYPE': 2,  # String
            'FORMULA': '@layer_name',
            'INPUT': parameters['DOKdatastrm'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['FeltkalkulatorNavn'] = processing.run('native:fieldcalculator', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(1)
        if feedback.isCanceled():
            return {}

        # Clip
        alg_params = {
            'INPUT': outputs['FeltkalkulatorNavn']['OUTPUT'],
            'OVERLAY': parameters['Interesseomrde'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['Clip'] = processing.run('native:clip', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(2)
        if feedback.isCanceled():
            return {}

        # Feltkalkulator - Areal
        alg_params = {
            'FIELD_LENGTH': 4,
            'FIELD_NAME': 'Areal_daa',
            'FIELD_PRECISION': 0,
            'FIELD_TYPE': 0,  # Float
            'FORMULA': 'round($area/1000,2)',
            'INPUT': outputs['Clip']['OUTPUT'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['FeltkalkulatorAreal'] = processing.run('native:fieldcalculator', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(3)
        if feedback.isCanceled():
            return {}

        # Collect geometries
        alg_params = {
            'FIELD': [''],
            'INPUT': outputs['FeltkalkulatorAreal']['OUTPUT'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['CollectGeometries'] = processing.run('native:collect', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(4)
        if feedback.isCanceled():
            return {}

        # Retain fields
        alg_params = {
            'FIELDS': ['type','Areal_daa','dato','opphav','oppdateringsdato'],
            'INPUT': outputs['CollectGeometries']['OUTPUT'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['RetainFields'] = processing.run('native:retainfields', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(5)
        if feedback.isCanceled():
            return {}

        # Remove null geometries
        alg_params = {
            'INPUT': outputs['RetainFields']['OUTPUT'],
            'REMOVE_EMPTY': True,
            'NULL_OUTPUT': QgsProcessing.TEMPORARY_OUTPUT,
            'OUTPUT': parameters['Omrdeanalyse']
        }
        outputs['RemoveNullGeometries'] = processing.run('native:removenullgeometries', alg_params, context=context, feedback=feedback, is_child_algorithm=True)
        results['Omrdeanalyse'] = outputs['RemoveNullGeometries']['OUTPUT']

        feedback.setCurrentStep(6)
        if feedback.isCanceled():
            return {}

        # Set style for vector layer
        alg_params = {
            'INPUT': outputs['RemoveNullGeometries']['NULL_OUTPUT'],
            'STYLE': 'C:\\Users\\schhen\\Desktop\\DOK-analyse\\QGIS-analyse\\Style\\Områdeanalyse_resultater.qml'
        }
        outputs['SetStyleForVectorLayer'] = processing.run('qgis:setstyleforvectorlayer', alg_params, context=context, feedback=feedback, is_child_algorithm=True)
        return results

    def name(self):
        return 'DOK-analyse (Område)'

    def displayName(self):
        return 'DOK-analyse (Område)'

    def group(self):
        return ''

    def groupId(self):
        return ''

    def createInstance(self):
        return DokanalyseOmrde()
