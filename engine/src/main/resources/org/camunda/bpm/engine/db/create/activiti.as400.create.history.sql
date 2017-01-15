create table ACT_HI_PROCINST (
    ID_ varchar(64) not null,
    PROC_INST_ID_ varchar(64) not null,
    BUSINESS_KEY_ varchar(255),
    PROC_DEF_KEY_ varchar(255),
    PROC_DEF_ID_ varchar(64) not null,
    START_TIME_ timestamp not null,
    END_TIME_ timestamp,
    DURATION_ bigint,
    START_USER_ID_ varchar(255),
    START_ACT_ID_ varchar(255),
    END_ACT_ID_ varchar(255),
    SUPER_PROCESS_INSTANCE_ID_ varchar(64),
    SUPER_CASE_INSTANCE_ID_ varchar(64),
    CASE_INST_ID_ varchar(64),
    DELETE_REASON_ varchar(4000),
    TENANT_ID_ varchar(64),
    STATE_ varchar(255),
    primary key (ID_)
);

alter table ACT_HI_PROCINST add constraint PROC_INST_ID_ unique(PROC_INST_ID_);

create table ACT_HI_ACTINST (
    ID_ varchar(64) not null,
    PARENT_ACT_INST_ID_ varchar(64),
    PROC_DEF_KEY_ varchar(255),
    PROC_DEF_ID_ varchar(64) not null,
    PROC_INST_ID_ varchar(64) not null,
    EXECUTION_ID_ varchar(64) not null,
    ACT_ID_ varchar(255) not null,
    TASK_ID_ varchar(64),
    CALL_PROC_INST_ID_ varchar(64),
    CALL_CASE_INST_ID_ varchar(64),
    ACT_NAME_ varchar(255),
    ACT_TYPE_ varchar(255) not null,
    ASSIGNEE_ varchar(64),
    START_TIME_ timestamp not null,
    END_TIME_ timestamp,
    DURATION_ bigint,
    ACT_INST_STATE_ integer,
    SEQUENCE_COUNTER_ bigint,
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_TASKINST (
    ID_ varchar(64) not null,
    TASK_DEF_KEY_ varchar(255),
    PROC_DEF_KEY_ varchar(255),
    PROC_DEF_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    EXECUTION_ID_ varchar(64),
    CASE_DEF_KEY_ varchar(255),
    CASE_DEF_ID_ varchar(64),
    CASE_INST_ID_ varchar(64),
    CASE_EXECUTION_ID_ varchar(64),
    ACT_INST_ID_ varchar(64),
    NAME_ varchar(255),
    PARENT_TASK_ID_ varchar(64),
    DESCRIPTION_ varchar(4000),
    OWNER_ varchar(255),
    ASSIGNEE_ varchar(255),
    START_TIME_ timestamp not null,
    END_TIME_ timestamp,
    DURATION_ bigint,
    DELETE_REASON_ varchar(4000),
    PRIORITY_ integer,
    DUE_DATE_ timestamp,
    FOLLOW_UP_DATE_ timestamp,
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_VARINST (
    ID_ varchar(64) not null,
    PROC_DEF_KEY_ varchar(255),
    PROC_DEF_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    EXECUTION_ID_ varchar(64),
    ACT_INST_ID_ varchar(64),
    CASE_DEF_KEY_ varchar(255),
    CASE_DEF_ID_ varchar(64),
    CASE_INST_ID_ varchar(64),
    CASE_EXECUTION_ID_ varchar(64),
    TASK_ID_ varchar(64),
    NAME_ varchar(255) not null,
    VAR_TYPE_ varchar(100),
    REV_ integer,
    BYTEARRAY_ID_ varchar(64),
    DOUBLE_ double precision,
    LONG_ bigint,
    TEXT_ varchar(4000),
    TEXT2_ varchar(4000),
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_DETAIL (
    ID_ varchar(64) not null,
    TYPE_ varchar(255) not null,
    PROC_DEF_KEY_ varchar(255),
    PROC_DEF_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    EXECUTION_ID_ varchar(64),
    CASE_DEF_KEY_ varchar(255),
    CASE_DEF_ID_ varchar(64),
    CASE_INST_ID_ varchar(64),
    CASE_EXECUTION_ID_ varchar(64),
    TASK_ID_ varchar(64),
    ACT_INST_ID_ varchar(64),
    VAR_INST_ID_ varchar(64),
    NAME_ varchar(255) not null,
    VAR_TYPE_ varchar(255),
    REV_ integer,
    TIME_ timestamp not null,
    BYTEARRAY_ID_ varchar(64),
    DOUBLE_ double precision,
    LONG_ bigint,
    TEXT_ varchar(4000),
    TEXT2_ varchar(4000),
    SEQUENCE_COUNTER_ bigint,
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_IDENTITYLINK (
    ID_ varchar(64) not null,
    TIMESTAMP_ timestamp not null,
    TYPE_ varchar(255),
    USER_ID_ varchar(255),
    GROUP_ID_ varchar(255),
    TASK_ID_ varchar(64),
    PROC_DEF_ID_ varchar(64),
    OPERATION_TYPE_ varchar(64),
    ASSIGNER_ID_ varchar(64),
    PROC_DEF_KEY_ varchar(255),
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_COMMENT (
    ID_ varchar(64) not null,
    TYPE_ varchar(255),
    TIME_ timestamp not null,
    USER_ID_ varchar(255),
    TASK_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    ACTION_ varchar(255),
    MESSAGE_ varchar(4000),
    FULL_MSG_ BLOB,
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_ATTACHMENT (
    ID_ varchar(64) not null,
    REV_ integer,
    USER_ID_ varchar(255),
    NAME_ varchar(255),
    DESCRIPTION_ varchar(4000),
    TYPE_ varchar(255),
    TASK_ID_ varchar(64),
    PROC_INST_ID_ varchar(64),
    URL_ varchar(4000),
    CONTENT_ID_ varchar(64),
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_OP_LOG (
    ID_ varchar(64) not null,
    DEPLOYMENT_ID_ varchar(64),
    PROC_DEF_ID_ varchar(64),
    PROC_DEF_KEY_ varchar(255),
    PROC_INST_ID_ varchar(64),
    EXECUTION_ID_ varchar(64),
    CASE_DEF_ID_ varchar(64),
    CASE_INST_ID_ varchar(64),
    CASE_EXECUTION_ID_ varchar(64),
    TASK_ID_ varchar(64),
    JOB_ID_ varchar(64),
    JOB_DEF_ID_ varchar(64),
    BATCH_ID_ varchar(64),
    USER_ID_ varchar(255),
    TIMESTAMP_ timestamp not null,
    OPERATION_TYPE_ varchar(64),
    OPERATION_ID_ varchar(64),
    ENTITY_TYPE_ varchar(30),
    PROPERTY_ varchar(64),
    ORG_VALUE_ varchar(4000),
    NEW_VALUE_ varchar(4000),
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_INCIDENT (
  ID_ varchar(64) not null,
  PROC_DEF_KEY_ varchar(255),
  PROC_DEF_ID_ varchar(64),
  PROC_INST_ID_ varchar(64),
  EXECUTION_ID_ varchar(64),
  CREATE_TIME_ timestamp not null,
  END_TIME_ timestamp,
  INCIDENT_MSG_ varchar(4000),
  INCIDENT_TYPE_ varchar(255) not null,
  ACTIVITY_ID_ varchar(255),
  CAUSE_INCIDENT_ID_ varchar(64),
  ROOT_CAUSE_INCIDENT_ID_ varchar(64),
  CONFIGURATION_ varchar(255),
  INCIDENT_STATE_ integer,
  TENANT_ID_ varchar(64),
  JOB_DEF_ID_ varchar(64),
  primary key (ID_)
);

create table ACT_HI_JOB_LOG (
    ID_ varchar(64) not null,
    TIMESTAMP_ timestamp not null,
    JOB_ID_ varchar(64) not null,
    JOB_DUEDATE_ timestamp,
    JOB_RETRIES_ integer,
    JOB_PRIORITY_ bigint not null default 0,
    JOB_EXCEPTION_MSG_ varchar(4000),
    JOB_EXCEPTION_STACK_ID_ varchar(64),
    JOB_STATE_ integer,
    JOB_DEF_ID_ varchar(64),
    JOB_DEF_TYPE_ varchar(255),
    JOB_DEF_CONFIGURATION_ varchar(255),
    ACT_ID_ varchar(255),
    EXECUTION_ID_ varchar(64),
    PROCESS_INSTANCE_ID_ varchar(64),
    PROCESS_DEF_ID_ varchar(64),
    PROCESS_DEF_KEY_ varchar(255),
    DEPLOYMENT_ID_ varchar(64),
    SEQUENCE_COUNTER_ bigint,
    TENANT_ID_ varchar(64),
    primary key (ID_)
);

create table ACT_HI_BATCH (
    ID_ varchar(64) not null,
    TYPE_ varchar(255),
    TOTAL_JOBS_ integer,
    JOBS_PER_SEED_ integer,
    INVOCATIONS_PER_JOB_ integer,
    SEED_JOB_DEF_ID_ varchar(64),
    MONITOR_JOB_DEF_ID_ varchar(64),
    BATCH_JOB_DEF_ID_ varchar(64),
    TENANT_ID_  varchar(64),
    START_TIME_ timestamp not null,
    END_TIME_ timestamp,
    primary key (ID_)
);

create index ACT_IDX_HI_PRO_INST_END on ACT_HI_PROCINST(END_TIME_);
create index ACT_IDX_HI_PRO_I_BUSKEY on ACT_HI_PROCINST(BUSINESS_KEY_);
create index ACT_IDX_HI_PRO_INST_TENANT_ID on ACT_HI_PROCINST(TENANT_ID_);
create index ACT_IDX_HI_PRO_INST_PROC_DEF_KEY on ACT_HI_PROCINST(PROC_DEF_KEY_);


create index ACT_IDX_HI_ACT_INST_START on ACT_HI_ACTINST(START_TIME_);
create index ACT_IDX_HI_ACT_INST_END on ACT_HI_ACTINST(END_TIME_);
create index ACT_IDX_HI_ACT_INST_PROCINST on ACT_HI_ACTINST(PROC_INST_ID_, ACT_ID_);
create index ACT_IDX_HI_ACT_INST_COMP on ACT_HI_ACTINST(EXECUTION_ID_, ACT_ID_, END_TIME_, ID_);
create index ACT_IDX_HI_ACT_INST_STATS on ACT_HI_ACTINST(PROC_DEF_ID_, ACT_ID_, END_TIME_, ACT_INST_STATE_);
create index ACT_IDX_HI_ACT_INST_TENANT_ID on ACT_HI_ACTINST(TENANT_ID_);
create index ACT_IDX_HI_ACT_INST_PROC_DEF_KEY on ACT_HI_ACTINST(PROC_DEF_KEY_);

create index ACT_IDX_HI_TASK_INST_TENANT_ID on ACT_HI_TASKINST(TENANT_ID_);
create index ACT_IDX_HI_TASK_INST_PROC_DEF_KEY on ACT_HI_TASKINST(PROC_DEF_KEY_);

create index ACT_IDX_HI_DETAIL_PROC_INST on ACT_HI_DETAIL(PROC_INST_ID_);
create index ACT_IDX_HI_DETAIL_ACT_INST on ACT_HI_DETAIL(ACT_INST_ID_);
create index ACT_IDX_HI_DETAIL_CASE_INST on ACT_HI_DETAIL(CASE_INST_ID_);
create index ACT_IDX_HI_DETAIL_CASE_EXEC on ACT_HI_DETAIL(CASE_EXECUTION_ID_);
create index ACT_IDX_HI_DETAIL_TIME on ACT_HI_DETAIL(TIME_);
create index ACT_IDX_HI_DETAIL_NAME on ACT_HI_DETAIL(NAME_);
create index ACT_IDX_HI_DETAIL_TASK_ID on ACT_HI_DETAIL(TASK_ID_);
create index ACT_IDX_HI_DETAIL_TENANT_ID on ACT_HI_DETAIL(TENANT_ID_);
create index ACT_IDX_HI_DETAIL_PROC_DEF_KEY on ACT_HI_DETAIL(PROC_DEF_KEY_);

create index ACT_IDX_HI_IDENT_LNK_USER on ACT_HI_IDENTITYLINK(USER_ID_);
create index ACT_IDX_HI_IDENT_LNK_GROUP on ACT_HI_IDENTITYLINK(GROUP_ID_);
create index ACT_IDX_HI_IDENT_LNK_TENANT_ID on ACT_HI_IDENTITYLINK(TENANT_ID_);
create index ACT_IDX_HI_IDENT_LNK_PROC_DEF_KEY on ACT_HI_IDENTITYLINK(PROC_DEF_KEY_);

create index ACT_IDX_HI_PROCVAR_PROC_INST on ACT_HI_VARINST(PROC_INST_ID_);
create index ACT_IDX_HI_PROCVAR_NAME_TYPE on ACT_HI_VARINST(NAME_, VAR_TYPE_);
create index ACT_IDX_HI_CASEVAR_CASE_INST on ACT_HI_VARINST(CASE_INST_ID_);
create index ACT_IDX_HI_VAR_INST_TENANT_ID on ACT_HI_VARINST(TENANT_ID_);
create index ACT_IDX_HI_VAR_INST_PROC_DEF_KEY on ACT_HI_VARINST(PROC_DEF_KEY_);


create index ACT_IDX_HI_INCIDENT_TENANT_ID on ACT_HI_INCIDENT(TENANT_ID_);
create index ACT_IDX_HI_INCIDENT_PROC_DEF_KEY on ACT_HI_INCIDENT(PROC_DEF_KEY_);


create index ACT_IDX_HI_JOB_LOG_PROCINST on ACT_HI_JOB_LOG(PROCESS_INSTANCE_ID_);
create index ACT_IDX_HI_JOB_LOG_PROCDEF on ACT_HI_JOB_LOG(PROCESS_DEF_ID_);
create index ACT_IDX_HI_JOB_LOG_TENANT_ID on ACT_HI_JOB_LOG(TENANT_ID_);
create index ACT_IDX_HI_JOB_LOG_JOB_DEF_ID on ACT_HI_JOB_LOG(JOB_DEF_ID_);
create index ACT_IDX_HI_JOB_LOG_PROC_DEF_KEY on ACT_HI_JOB_LOG(PROCESS_DEF_KEY_);


create index ACT_IDX_HI_OP_LOG_PROCINST on ACT_HI_OP_LOG(PROC_INST_ID_);
create index ACT_IDX_HI_OP_LOG_PROCDEF on ACT_HI_OP_LOG(PROC_DEF_ID_);

--- labels
label on table ACT_HI_PROCINST is 'ACT_HI_PROCINST';
label on table ACT_HI_ACTINST is 'ACT_HI_ACTINST';
label on table ACT_HI_TASKINST is 'ACT_HI_TASKINST';
label on table ACT_HI_VARINST is 'ACT_HI_VARINST';
label on table ACT_HI_DETAIL is 'ACT_HI_DETAIL';
label on table ACT_HI_IDENTITYLINK is 'ACT_HI_IDENTITYLINK';
label on table ACT_HI_COMMENT is 'ACT_HI_COMMENT';
label on table ACT_HI_ATTACHMENT is 'ACT_HI_ATTACHMENT';
label on table ACT_HI_OP_LOG is 'ACT_HI_OP_LOG';
label on table ACT_HI_INCIDENT is 'ACT_HI_INCIDENT';
label on table ACT_HI_JOB_LOG is 'ACT_HI_JOB_LOG';
label on table ACT_HI_BATCH is 'ACT_HI_BATCH';

label on index ACT_IDX_HI_PRO_INST_END is 'ACT_IDX_HI_PRO_INST_END';
label on index ACT_IDX_HI_PRO_I_BUSKEY is 'ACT_IDX_HI_PRO_I_BUSKEY';
label on index ACT_IDX_HI_PRO_INST_TENANT_ID is 'ACT_IDX_HI_PRO_INST_TENANT_ID';
label on index ACT_IDX_HI_PRO_INST_PROC_DEF_KEY is 'ACT_IDX_HI_PRO_INST_PROC_DEF_KEY';
label on index ACT_IDX_HI_ACT_INST_START is 'ACT_IDX_HI_ACT_INST_START';
label on index ACT_IDX_HI_ACT_INST_END is 'ACT_IDX_HI_ACT_INST_END';
label on index ACT_IDX_HI_ACT_INST_PROCINST is 'ACT_IDX_HI_ACT_INST_PROCINST';
label on index ACT_IDX_HI_ACT_INST_COMP is 'ACT_IDX_HI_ACT_INST_COMP';
label on index ACT_IDX_HI_ACT_INST_STATS is 'ACT_IDX_HI_ACT_INST_STATS';
label on index ACT_IDX_HI_ACT_INST_TENANT_ID is 'ACT_IDX_HI_ACT_INST_TENANT_ID';
label on index ACT_IDX_HI_ACT_INST_PROC_DEF_KEY is 'ACT_IDX_HI_ACT_INST_PROC_DEF_KEY';
label on index ACT_IDX_HI_TASK_INST_TENANT_ID is 'ACT_IDX_HI_TASK_INST_TENANT_ID';
label on index ACT_IDX_HI_TASK_INST_PROC_DEF_KEY is 'ACT_IDX_HI_TASK_INST_PROC_DEF_KEY';
label on index ACT_IDX_HI_DETAIL_PROC_INST is 'ACT_IDX_HI_DETAIL_PROC_INST';
label on index ACT_IDX_HI_DETAIL_ACT_INST is 'ACT_IDX_HI_DETAIL_ACT_INST';
label on index ACT_IDX_HI_DETAIL_CASE_INST is 'ACT_IDX_HI_DETAIL_CASE_INST';
label on index ACT_IDX_HI_DETAIL_CASE_EXEC is 'ACT_IDX_HI_DETAIL_CASE_EXEC';
label on index ACT_IDX_HI_DETAIL_TIME is 'ACT_IDX_HI_DETAIL_TIME';
label on index ACT_IDX_HI_DETAIL_NAME is 'ACT_IDX_HI_DETAIL_NAME';
label on index ACT_IDX_HI_DETAIL_TASK_ID is 'ACT_IDX_HI_DETAIL_TASK_ID';
label on index ACT_IDX_HI_DETAIL_TENANT_ID is 'ACT_IDX_HI_DETAIL_TENANT_ID';
label on index ACT_IDX_HI_DETAIL_PROC_DEF_KEY is 'ACT_IDX_HI_DETAIL_PROC_DEF_KEY';
label on index ACT_IDX_HI_IDENT_LNK_USER is 'ACT_IDX_HI_IDENT_LNK_USER';
label on index ACT_IDX_HI_IDENT_LNK_GROUP is 'ACT_IDX_HI_IDENT_LNK_GROUP';
label on index ACT_IDX_HI_IDENT_LNK_TENANT_ID is 'ACT_IDX_HI_IDENT_LNK_TENANT_ID';
label on index ACT_IDX_HI_IDENT_LNK_PROC_DEF_KEY is 'ACT_IDX_HI_IDENT_LNK_PROC_DEF_KEY';
label on index ACT_IDX_HI_PROCVAR_PROC_INST is 'ACT_IDX_HI_PROCVAR_PROC_INST';
label on index ACT_IDX_HI_PROCVAR_NAME_TYPE is 'ACT_IDX_HI_PROCVAR_NAME_TYPE';
label on index ACT_IDX_HI_CASEVAR_CASE_INST is 'ACT_IDX_HI_CASEVAR_CASE_INST';
label on index ACT_IDX_HI_VAR_INST_TENANT_ID is 'ACT_IDX_HI_VAR_INST_TENANT_ID';
label on index ACT_IDX_HI_VAR_INST_PROC_DEF_KEY is 'ACT_IDX_HI_VAR_INST_PROC_DEF_KEY';
label on index ACT_IDX_HI_INCIDENT_TENANT_ID is 'ACT_IDX_HI_INCIDENT_TENANT_ID';
label on index ACT_IDX_HI_INCIDENT_PROC_DEF_KEY is 'ACT_IDX_HI_INCIDENT_PROC_DEF_KEY';
label on index ACT_IDX_HI_JOB_LOG_PROCINST is 'ACT_IDX_HI_JOB_LOG_PROCINST';
label on index ACT_IDX_HI_JOB_LOG_PROCDEF is 'ACT_IDX_HI_JOB_LOG_PROCDEF';
label on index ACT_IDX_HI_JOB_LOG_TENANT_ID is 'ACT_IDX_HI_JOB_LOG_TENANT_ID';
label on index ACT_IDX_HI_JOB_LOG_JOB_DEF_ID is 'ACT_IDX_HI_JOB_LOG_JOB_DEF_ID';
label on index ACT_IDX_HI_JOB_LOG_PROC_DEF_KEY is 'ACT_IDX_HI_JOB_LOG_PROC_DEF_KEY';
label on index ACT_IDX_HI_OP_LOG_PROCINST is 'ACT_IDX_HI_OP_LOG_PROCINST';
label on index ACT_IDX_HI_OP_LOG_PROCDEF is 'ACT_IDX_HI_OP_LOG_PROCDEF';