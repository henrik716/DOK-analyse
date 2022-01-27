"""
Model exported as python.
Name : DOK-analyse (Nærmeste objekt)
Group : 
With QGIS : 32000
"""

from qgis.core import QgsProcessing
from qgis.core import QgsProcessingAlgorithm
from qgis.core import QgsProcessingMultiStepFeedback
from qgis.core import QgsProcessingParameterVectorLayer
from qgis.core import QgsProcessingParameterFeatureSink
import processing


class DokanalyseNrmesteObjekt(QgsProcessingAlgorithm):

    def initAlgorithm(self, config=None):
        self.addParameter(QgsProcessingParameterVectorLayer('DOKdata', 'DOK data', types=[QgsProcessing.TypeVectorAnyGeometry], defaultValue=None))
        self.addParameter(QgsProcessingParameterVectorLayer('Interesseomrde', 'Interesseområde', types=[QgsProcessing.TypeVectorPolygon], defaultValue=None))
        self.addParameter(QgsProcessingParameterFeatureSink('NrmesteObjekt', 'Nærmeste Objekt', type=QgsProcessing.TypeVectorAnyGeometry, createByDefault=True, defaultValue=None))

    def processAlgorithm(self, parameters, context, model_feedback):
        # Use a multi-step feedback, so that individual child algorithm progress reports are adjusted for the
        # overall progress through the model
        feedback = QgsProcessingMultiStepFeedback(10, model_feedback)
        results = {}
        outputs = {}

        # Feltkalkulator - v.distance egenskap
        alg_params = {
            'FIELD_LENGTH': 0,
            'FIELD_NAME': 'midlertidig',
            'FIELD_PRECISION': 0,
            'FIELD_TYPE': 2,  # String
            'FORMULA': '\'midlertidig\'',
            'INPUT': parameters['Interesseomrde'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['FeltkalkulatorVdistanceEgenskap'] = processing.run('native:fieldcalculator', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(1)
        if feedback.isCanceled():
            return {}

        # Feltkalkulator - Navn
        alg_params = {
            'FIELD_LENGTH': 50,
            'FIELD_NAME': 'type',
            'FIELD_PRECISION': 0,
            'FIELD_TYPE': 2,  # String
            'FORMULA': '@layer_name',
            'INPUT': parameters['DOKdata'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['FeltkalkulatorNavn'] = processing.run('native:fieldcalculator', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(2)
        if feedback.isCanceled():
            return {}

        # Fix geometries
        alg_params = {
            'INPUT': outputs['FeltkalkulatorNavn']['OUTPUT'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['FixGeometries'] = processing.run('native:fixgeometries', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(3)
        if feedback.isCanceled():
            return {}

        # v.distance
        alg_params = {
            'GRASS_MIN_AREA_PARAMETER': 0.0001,
            'GRASS_OUTPUT_TYPE_PARAMETER': 0,  # auto
            'GRASS_REGION_PARAMETER': None,
            'GRASS_SNAP_TOLERANCE_PARAMETER': -1,
            'GRASS_VECTOR_DSCO': '',
            'GRASS_VECTOR_EXPORT_NOCAT': False,
            'GRASS_VECTOR_LCO': '',
            'column': ['fid'],
            'dmax': -1,
            'dmin': -1,
            'from': outputs['FeltkalkulatorVdistanceEgenskap']['OUTPUT'],
            'from_type': [0,1,3],  # point,line,area
            'to': outputs['FixGeometries']['OUTPUT'],
            'to_column': '',
            'to_type': [0,1,3],  # point,line,area
            'upload': [0],  # cat
            'from_output': QgsProcessing.TEMPORARY_OUTPUT,
            'output': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['Vdistance'] = processing.run('grass7:v.distance', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(4)
        if feedback.isCanceled():
            return {}

        # Feltkalkulator - Avstand
        alg_params = {
            'FIELD_LENGTH': 0,
            'FIELD_NAME': 'avstand',
            'FIELD_PRECISION': 0,
            'FIELD_TYPE': 0,  # Float
            'FORMULA': 'round($length,2)',
            'INPUT': outputs['Vdistance']['output'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['FeltkalkulatorAvstand'] = processing.run('native:fieldcalculator', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(5)
        if feedback.isCanceled():
            return {}

        # Join attributes by nearest
        alg_params = {
            'DISCARD_NONMATCHING': False,
            'FIELDS_TO_COPY': [''],
            'INPUT': outputs['FeltkalkulatorAvstand']['OUTPUT'],
            'INPUT_2': outputs['FixGeometries']['OUTPUT'],
            'MAX_DISTANCE': None,
            'NEIGHBORS': 1,
            'PREFIX': '',
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['JoinAttributesByNearest'] = processing.run('native:joinbynearest', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(6)
        if feedback.isCanceled():
            return {}

        # Retain fields
        alg_params = {
            'FIELDS': ['type','avstand','dato','opphav','oppdateringsdato'],
            'INPUT': outputs['JoinAttributesByNearest']['OUTPUT'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['RetainFields'] = processing.run('native:retainfields', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(7)
        if feedback.isCanceled():
            return {}

        # Feltkalkulator - Merknad
        alg_params = {
            'FIELD_LENGTH': 0,
            'FIELD_NAME': 'merknad',
            'FIELD_PRECISION': 0,
            'FIELD_TYPE': 2,  # String
            'FORMULA': 'CASE \r\n  WHEN \"avstand\" > 100 THEN \'Over 100m unna\'\r\n  WHEN \"avstand\" > 100 > 51 THEN \'Mellom 50-100m\'\r\n  WHEN \"avstand\" <= 50 THEN \'Manuell kontroll\'\r\n  ELSE \'Manuell kontroll\'\r\nEND',
            'INPUT': outputs['RetainFields']['OUTPUT'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['FeltkalkulatorMerknad'] = processing.run('native:fieldcalculator', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(8)
        if feedback.isCanceled():
            return {}

        # Drop geometries
        alg_params = {
            'INPUT': outputs['FeltkalkulatorMerknad']['OUTPUT'],
            'OUTPUT': QgsProcessing.TEMPORARY_OUTPUT
        }
        outputs['DropGeometries'] = processing.run('native:dropgeometries', alg_params, context=context, feedback=feedback, is_child_algorithm=True)

        feedback.setCurrentStep(9)
        if feedback.isCanceled():
            return {}

        # Delete duplicates by attribute
        alg_params = {
            'FIELDS': ['type'],
            'INPUT': outputs['DropGeometries']['OUTPUT'],
            'OUTPUT': parameters['NrmesteObjekt']
        }
        outputs['DeleteDuplicatesByAttribute'] = processing.run('native:removeduplicatesbyattribute', alg_params, context=context, feedback=feedback, is_child_algorithm=True)
        results['NrmesteObjekt'] = outputs['DeleteDuplicatesByAttribute']['OUTPUT']
        return results

    def name(self):
        return 'DOK-analyse (Nærmeste objekt)'

    def displayName(self):
        return 'DOK-analyse (Nærmeste objekt)'

    def group(self):
        return ''

    def groupId(self):
        return ''

    def createInstance(self):
        return DokanalyseNrmesteObjekt()
