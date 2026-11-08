export interface Patient { id:number; name:string; gender:string; birthdate:string; city:string; street:string; house:string; flat:string; revision:number; studyCount:number; lastStudy:string|null }
export interface StudySummary { id:number; patientId:number; patientName?:string; date:string; title:string; origin:string; status:string; revision:number; templateId:number; doctorId:number; doctor:string }
export interface FieldValue { value:string; type:string }
export interface Study { id:number; patient_id:number; date:string; template_id:number; doctor_id:number; title:string; conclusion:string; addition:string; fields:Record<string,FieldValue>; legacy_version:string|null; origin:string; status:string; revision:number; doctor:string; patientName:string; patientBirthdate:string; templateCode:string }
export interface DatabaseInfo { path:string; patients:number; studies:number; templates:{id:number;name:string;code:string}[]; doctors:{id:number;name:string}[]; migration:string }
export interface Page<T> {total:number;items:T[]}
export interface FieldDefinition {key:string;label:string;kind:string;group?:string;valueType?:string;options?:{label:string;value:string}[]}
