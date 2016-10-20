/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.camunda.bpm.engine.impl.pvm.runtime.operation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.camunda.bpm.engine.impl.persistence.entity.DelayedVariableEvent;
import org.camunda.bpm.engine.impl.persistence.entity.ExecutionEntity;
import org.camunda.bpm.engine.impl.pvm.process.ActivityImpl;
import org.camunda.bpm.engine.impl.pvm.runtime.PvmExecutionImpl;

/**
 * @author Thorben Lindhauer
 *
 */
public class PvmAtomicOperationScopeDispatchDelayedEvents implements PvmAtomicOperation {

  @Override
  public void execute(PvmExecutionImpl execution) {
    ExecutionEntity executionEntity = (ExecutionEntity) execution;
    PvmAtomicOperationContinuation nextOperation = executionEntity.popContinuation();

    String activityInstanceId = getActivityInstanceId(executionEntity);

    dispatchScopeEvents(executionEntity);

    executionEntity = executionEntity.getReplacedBy() != null ? executionEntity.getReplacedBy() : executionEntity;
    String currentActivityInstanceId = getActivityInstanceId(executionEntity);

    if (nextOperation != null && activityInstanceId.equals(currentActivityInstanceId) && !executionEntity.isCanceled()) {
      nextOperation.execute(executionEntity);
    }
  }

  protected void dispatchScopeEvents(ExecutionEntity execution) {
    ExecutionEntity scopeExecution = (ExecutionEntity) (execution.isScope() ? execution : execution.getParent());

    List<DelayedVariableEvent> delayedEvents = new ArrayList<DelayedVariableEvent>(scopeExecution.getDelayedEvents());
    scopeExecution.clearDelayedEvents();

    Map<ExecutionEntity, String> activityInstanceIds = new HashMap<ExecutionEntity, String>();

    for (DelayedVariableEvent event : delayedEvents) {
      ExecutionEntity targetScope = event.getTargetScope();

      String targetScopeActivityInstanceId = getActivityInstanceId(targetScope);
      activityInstanceIds.put(targetScope, targetScopeActivityInstanceId);

    }

    for (DelayedVariableEvent event : delayedEvents) {

      ExecutionEntity targetScope = event.getTargetScope();
      ExecutionEntity replacedBy = targetScope.getReplacedBy();

      // if tree compacted
      if (replacedBy != null && targetScope.getParent() == replacedBy) {
        targetScope = replacedBy;
      }

      String currentActivityInstanceId = getActivityInstanceId(targetScope);
      final String lastActivityInstanceId = activityInstanceIds.get(targetScope);
      if (lastActivityInstanceId != null && lastActivityInstanceId.equals(currentActivityInstanceId) && !targetScope.isEnded()) {
        targetScope.dispatchEvent(event.getEvent());
      }
    }
  }

  private String getActivityInstanceId(ExecutionEntity targetScope) {
    if (targetScope.isConcurrent()) {
      return targetScope.getActivityInstanceId();
    } else {
      ActivityImpl targetActivity = targetScope.getActivity();
      if (targetActivity != null && targetActivity.getActivities().isEmpty()) {
        // TODO: does not always work with a compacted tree, i.e. where targetScope is
        // in a non-scope activity, because we have to consider if the variable was set in the context
        // of that non-scope activity, or in the context of the containing scope
        return targetScope.getActivityInstanceId();
      } else {
        return targetScope.getParentActivityInstanceId();
      }
    }
  }

  @Override
  public boolean isAsync(PvmExecutionImpl instance) {
    return false;
  }

  @Override
  public String getCanonicalName() {
    return "dispatch-events";
  }

  @Override
  public boolean isAsyncCapable() {
    return false;
  }

}
