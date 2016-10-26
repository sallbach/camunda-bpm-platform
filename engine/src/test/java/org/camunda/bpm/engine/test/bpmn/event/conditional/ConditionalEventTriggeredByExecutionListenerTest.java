/*
 * Copyright 2016 camunda services GmbH.
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *       http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

package org.camunda.bpm.engine.test.bpmn.event.conditional;

import org.camunda.bpm.engine.delegate.ExecutionListener;
import org.camunda.bpm.engine.runtime.ProcessInstance;
import org.camunda.bpm.engine.task.Task;
import org.camunda.bpm.engine.task.TaskQuery;
import org.camunda.bpm.model.bpmn.Bpmn;
import org.camunda.bpm.model.bpmn.BpmnModelInstance;
import org.camunda.bpm.model.bpmn.instance.SequenceFlow;
import org.camunda.bpm.model.bpmn.instance.camunda.CamundaExecutionListener;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.Arrays;
import java.util.Collection;

import static org.camunda.bpm.engine.test.api.runtime.migration.ModifiableBpmnModelInstance.modify;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

/**
 * @author Christopher Zell <christopher.zell@camunda.com>
 */
@RunWith(Parameterized.class)
public class ConditionalEventTriggeredByExecutionListenerTest extends AbstractConditionalEventTestCase {

  @Parameterized.Parameters(name = "{index}: {0}")
  public static Collection<Object[]> data() {
    return Arrays.asList(new Object[][] {
      {EXPR_SET_VARIABLE}, {EXPR_SET_VARIABLE_ON_PARENT}
    });
  }

  @Parameterized.Parameter
  public String exprToSetVariable;

  protected void deployEventSubProcessWithVariableIsSetInDelegationCode(BpmnModelInstance model, boolean isInterrupting) {
    deployEventSubProcessWithVariableIsSetInDelegationCode(model, CONDITIONAL_EVENT_PROCESS_KEY, isInterrupting);
  }

  protected void deployEventSubProcessWithVariableIsSetInDelegationCode(BpmnModelInstance model, String parentId, boolean isInterrupting) {

    final BpmnModelInstance modelInstance = modify(model)
      .addSubProcessTo(parentId)
      .id("eventSubProcess")
      .triggerByEvent()
      .embeddedSubProcess()
      .startEvent()
      .interrupting(isInterrupting)
      .conditionalEventDefinition(CONDITIONAL_EVENT)
      .condition(CONDITION_EXPR)
      .conditionalEventDefinitionDone()
      .userTask("taskAfterCond")
      .name(TASK_AFTER_CONDITION)
      .endEvent().done();

    engine.manageDeployment(repositoryService.createDeployment().addModelInstance(CONDITIONAL_MODEL, modelInstance).deploy());
  }


  @Test
  public void testSetVariableOnParentScopeInTakeListener() {
    final BpmnModelInstance modelInstance = Bpmn.createExecutableProcess(CONDITIONAL_EVENT_PROCESS_KEY)
      .startEvent()
      .subProcess()
      .embeddedSubProcess()
      .startEvent()
      .userTask(TASK_BEFORE_CONDITION_ID)
      .name(TASK_BEFORE_CONDITION)
      .sequenceFlowId(FLOW_ID)
      .userTask(TASK_WITH_CONDITION_ID)
      .endEvent()
      .subProcessDone()
      .endEvent()
      .done();
    CamundaExecutionListener listener = modelInstance.newInstance(CamundaExecutionListener.class);
    listener.setCamundaEvent(ExecutionListener.EVENTNAME_TAKE);
    listener.setCamundaExpression(exprToSetVariable);
    modelInstance.<SequenceFlow>getModelElementById(FLOW_ID).builder().addExtensionElement(listener);
    deployEventSubProcessWithVariableIsSetInDelegationCode(modelInstance, true);

    // given
    ProcessInstance procInst = runtimeService.startProcessInstanceByKey(CONDITIONAL_EVENT_PROCESS_KEY);

    TaskQuery taskQuery = taskService.createTaskQuery().processInstanceId(procInst.getId());
    Task task = taskQuery.singleResult();
    assertNotNull(task);
    assertEquals(TASK_BEFORE_CONDITION, task.getName());

    //when task is completed
    taskService.complete(task.getId());

    //then start listener sets variable
    //conditional event is triggered
    tasksAfterVariableIsSet = taskQuery.list();
    assertEquals(TASK_AFTER_CONDITION, tasksAfterVariableIsSet.get(0).getName());
  }

}
